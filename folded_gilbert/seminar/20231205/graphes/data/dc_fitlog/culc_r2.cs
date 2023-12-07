using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Runtime.Remoting.Messaging;

namespace Project1
{
    internal class Class1
    {

        static void Main(string[] args)
        {
            Runner.buffer(args);
        }

    }

    class Runner
    {

        public static void buffer(string[] args)
        {
            Test test = new Test();
            test.Execute(args);
        }
    }

    public class Test
    {

        int num;
        int sample;
        double fit_xrange_min = -0.01;
        double fit_xrange_max = 0.01;

        double[] fit_param_slope;
        double[] fit_param_intercept;
        double[] average;

        double[] sum_of_square;
        double[] sum_of_squared_residual;
        double[] sum_of_recursion;

        Extructer row_data;

        public void Execute(string[] args)
        {

            row_data = new Extructer();
            row_data.SetFilePath(args);
            row_data.Extruct_Data();

            fit_param_slope = new double[row_data.Data_Num];
            fit_param_intercept = new double[row_data.Data_Num];
            average = new double[row_data.Data_Num];
            sum_of_square = new double[row_data.Data_Num];
            sum_of_squared_residual = new double[row_data.Data_Num];
            sum_of_recursion = new double[row_data.Data_Num];

            num = row_data.Data_Num;
            sample = row_data.Sample_Num;

            Set_fit_param();
            Culc_sum_of_square();
            Culc_result();

        }

        private void Set_fit_param()
        {
            string[] buf = File.ReadAllLines(@"fit_param.dat");
            string[] line_buf = new string[10];

            for (int i = 1; i < num-1; i++)
            {

                line_buf = buf[i-1].Split(',');
                fit_param_slope[i] = double.Parse(line_buf[0]);
                fit_param_intercept[i] = double.Parse(line_buf[1]);

            }
        }

        private void Culc_sum_of_square()
        {

            for (int i = 0; i < num-1; i++)
            {
                average[i] = 0;

                sum_of_square[i] = 0;
                sum_of_recursion[i] = 0;
                sum_of_squared_residual[i] = 0;
            }

            int in_range_sample = 0;

            //calculate average
            for (int i = 0; i < sample; i++)
            {
                if (fit_xrange_min <= row_data.Data[i, 0] && row_data.Data[i, 0] <= fit_xrange_max)
                {

                    for (int j = 1; j <= num-2; j++)
                    {

                        average[j] += row_data.Data[i, j];

                    }

                    in_range_sample++;
                }
            }
            for (int j = 1; j <= num-2; j++)
            {
                average[j] /= in_range_sample;
            }

            //calulate summentions
            for (int i = 0; i < sample; i++)
            {

                if (fit_xrange_min <= row_data.Data[i, 0] && row_data.Data[i, 0] <= fit_xrange_max)
                {
                    for (int j = 1; j <= num-2; j++)
                    {

                        sum_of_square[j] += Math.Pow(row_data.Data[i, j] - average[j], 2);
                        sum_of_squared_residual[j] += Math.Pow(fit_param_slope[j] * row_data.Data[i, 0] + fit_param_intercept[j] - average[j], 2);
                        sum_of_recursion[j] += Math.Pow(fit_param_slope[j] * row_data.Data[i, 0] + fit_param_intercept[j] - row_data.Data[i, j], 0);

                    }

                }

            }

        }

        private void Culc_result()
        {

            using (StreamWriter sw = new StreamWriter("fit_param.dat", false))
            {

                for (int j = 1; j <= num - 2; j++)
                {

                    sw.WriteLine(fit_param_slope[j].ToString() + "," + fit_param_intercept[j] + "," + sum_of_squared_residual[j].ToString());

                }

            }

        }

    }

    public class Extructer
    {

        #region 

        //data[colum , row]
        //data[ ,0] is x data
        private double[,] data;
        public double[,] Data
        {
            get
            {
                return data;
            }
        }
        private string path;
        private int data_num;
        public int Data_Num
        {
            get
            {
                return data_num;
            }
        }
        private int sample_num;
        public int Sample_Num
        {
            get
            {
                return sample_num;
            }
        }
        private string outfile;

        private string[] label;

        private string[,] cut_off;

        #endregion

        //ファイルパスの指定と書き出しファイル名の設定
        public string SetFilePath(string[] args)
        {
            string path = "";

            //コマンドラインからパスの受け取り
            if (args.Length == 1)
            {
                Write_path(args[0]);
                return args[0];
            }
            else
            {
                /*
                //ファイル選択ウィンドウからパスの選択
                OpenFileDialog ofd = new OpenFileDialog();
                ofd.Title = "select data file";
                if (ofd.ShowDialog() != DialogResult.OK)
                {
                    return null;
                }

                path = ofd.FileName;
                */

                Console.WriteLine("no file input");
                Console.ReadLine();
                Environment.Exit(0);
            }

            Write_path(path);

            return Path.Combine(Path.GetDirectoryName(path), Path.GetFileNameWithoutExtension(path) + "_cutoff.data");
        }

        //pathの格納
        private void Write_path(string str)
        {
            path = str;
        }

        //指定されたパスのデータをdouble型に変換、周波数は[,0]にまとめる
        public void Extruct_Data()
        {
            //とりあえず配列にすべてのデータを格納
            string[] buf = File.ReadAllLines(@path);

            //データ数のカウント
            data_num = 1;
            for (int i = 0; i < buf[4].Length; i++)
            {
                if (buf[4][i] == ';') data_num++;
            }

            //サンプル数のカウント
            sample_num = buf.Length - 6;

            data = new double[sample_num, data_num];

            //6行目から記録
            for (int i = 6; i < sample_num; i++)
            {

                //デリミタで文字列を分割
                string[] data_buf = buf[i].Split(',');

                for (int j = 0; j < data_num; j++)
                {

                    if (j == 0)
                    {
                        data[i - 6, 0] = double.Parse(data_buf[0]);
                    }
                    else
                    {
                        data[i - 6, j] = double.Parse(data_buf[2 * j - 1]);
                    }

                }


            }

            //データラベルの作成(ラベルに不要な文字を削る)。必要ならばコードを足す。
            label = new string[data_num + 1];
            label = buf[1].Split(';');

            for (int i = 1; i < label.Length; i++)
            {
                string tmp = label[i];
                label[i] = "";

                int equal = 0;
                int init = 0;
                int last = 0;

                //'='の位置の走査
                while (true)
                {
                    if (tmp[equal] == '=') break;

                    equal++;
                }

                //先頭の位置の検索
                init = equal;
                while (true)
                {
                    if (tmp[init - 1] == '(') break;
                    init--;
                }

                //ラベルの書き込み(1行目のみ)
                if (i == 1)
                {
                    label[0] = "";
                    for (int j = init; j < equal; j++)
                    {
                        label[0] += tmp[j];
                    }

                }

                //末尾の位置の検索
                last = equal;
                while (true)
                {
                    if (tmp[last + 1] == ')') break;
                    last++;
                }

                //検索した先頭から末尾までの書き込み
                for (int j = equal + 1; j <= last; j++)
                {
                    label[i] += tmp[j];
                }

            }

            //メモリの解放をガベコレに伝える
            buf = null;

        }


        //カットオフ周波数の記録
        public void CulcCutoff()
        {
            double dc;

            cut_off = new string[3, data_num + 1];

            cut_off[0, 0] = "";
            for (int i = 0; i < data_num; i++)
            {
                cut_off[0, i] = label[i];
            }

            cut_off[1, 0] = "cutoff_freq[Hz]";
            for (int i = 1; i < data_num; i++)
            {
                int count = 0;
                dc = data[0, i];

                //直流との絶対値の差が3dB以上になったらループを抜ける
                while (abs(dc, data[count, i]) < 3)
                {
                    count++;
                }

                cut_off[1, i] = data[count, 0].ToString();
                cut_off[2, i] = data[count, i].ToString();

                Console.WriteLine("sample : " + cut_off[0, i] + "\tdc : " + dc.ToString() + "\tcutoff : " + data[count, i].ToString() + " / " + cut_off[1, i] + " Hz");
            }

        }

        //ファイルへの書き込み
        public void WriteFile()
        {

            using (StreamWriter sw = new StreamWriter(outfile, false))
            {

                //sw.WriteLine("sample\tfreq[Hz]\tAmplitude");

                sw.WriteLine(cut_off[0, 0] + "\t" + "freq[Hz]" + "\t");

                for (int i = 1; i < data_num + 1; i++)
                {
                    sw.WriteLine(cut_off[0, i] + "\t" + cut_off[1, i] + "\t");
                }
            }

        }


        //二つの数字を比較し絶対値が3未満の時trueを、3以上の時falseを返す
        private static double abs(double lhs, double rhs)
        {
            double tmp = lhs - rhs;

            if (tmp < 0)
            {
                tmp *= -1;
            }

            return tmp;
        }

    }

}

