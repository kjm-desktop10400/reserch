; --------------------------------------------------------------------
; Parameterized cell of via array for ROHM 180nm CMOS TechnologyCreate
; Written by Keisuke Kawahara <7320529@ed.tus.ac.jp>
; --------------------------------------------------------------------

pcDefinePCell(
    list(
        ddGetObj("ROHMLIB")
        "VIA_ARRAY"
        "layout"
    )

    list(
        (llx "float" 0.0)
        (lly "float" 0.0)
        (urx "float" 0.0)
        (ury "float" 0.0)
    )

    let((width hight rows columns)
        width = urx - llx
        hight = ury - lly
        foreach(layer list("TopVia" "M4_M3" "M3_M2" "M2_M1")
            if(layer == "TopVia" then
                columns = floor(width / 0.72)
                rows = floor(hight / 0.72)
            else
                columns = floor(width / 0.56)
                rows = floor(hight / 0.56)
            )
            dbCreateVia(
                pcCellView
                techFindViaDefByName(techGetTechFile(pcCellView) layer)
                list((urx+llx)/2.0 (ury+lly)/2.0)
                "R0"
                list(list("cutRows" rows) list("cutColumns" columns))
            )
        )
    )
)