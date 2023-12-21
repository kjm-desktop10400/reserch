; ------------------------------------------------------------------------------
; Parameterized cell of octagonal spiral inductor for ROHM 180nm CMOS Technology
; Written by Keisuke Kawahara <7320529@ed.tus.ac.jp>
; ------------------------------------------------------------------------------

pcDefinePCell(
    list(
        ddGetObj("ROHMLIB")
        "IND_OCT"
        "layout"
    )

    list(
        (width "int" 6)
        (space "int" 3)
        (diameter "int" 100)
        (turns "int" 1)
        (leadLineLength "int" 14)
        (leadLine? "boolean" nil)
        (groundWall? "boolean" nil)
    )

    let((delta viaDefId leadLength tlineWidth wallWidth)
        delta = space + width
        leadLength = ceiling(leadLineLength + width / 2.0)
        tlineWidth = 28.8
        wallWidth = 6

        ; Drawing east side of spiral
        let((outsideDiameter outsideVertical outsideSlope insideDiameter insideVertical insideSlope x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 vertexes)
            for(i 0 turns
                outsideDiameter = diameter - 2 * delta * i
                outsideVertical = 0.4 * outsideDiameter
                outsideSlope = (outsideDiameter - outsideVertical) / 2.0
                insideDiameter = outsideDiameter - 2 * width
                insideVertical = 0.4 * insideDiameter
                insideSlope = (insideDiameter - insideVertical) / 2.0
                x1 = - width / 2.0
                y1 = - width / 2.0 + delta * i
                x2 = x1 + outsideVertical / 2.0 + width / 2.0
                y2 = y1
                x3 = x2 + outsideSlope
                y3 = y2 + outsideSlope
                x4 = x3
                y4 = y3 + outsideVertical
                x5 = x4 - outsideSlope
                y5 = y4 + outsideSlope
                x6 = x5 - outsideVertical / 2.0 - width / 2.0
                y6 = y5
                x7 = x6
                y7 = y6 - width
                x8 = x7 + insideVertical / 2.0 + width / 2.0
                y8 = y7
                x9 = x8 + insideSlope
                y9 = y8 - insideSlope
                x10 = x9
                y10 = y9 - insideVertical
                x11 = x10 - insideSlope
                y11 = y10 - insideSlope
                x12 = x11 - insideVertical / 2.0 - width / 2.0
                y12 = y11
                vertexes = list(x1:y1 x2:y2 x3:y3 x4:y4 x5:y5 x6:y6 x7:y7 x8:y8 x9:y9 x10:y10 x11:y11 x12:y12)
                dbCreatePolygon(
                    pcCellView
                    list("METAL5" "drawing")
                    vertexes
                )
            )
        )


        ; Drawing west side of spiral
        let((outsideDiameter outsideVertical outsideSlope insideDiameter insideVertical insideSlope x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 vertexes)
            for(i 0 turns-1
                outsideDiameter = diameter - 2 * delta * i
                outsideVertical = 0.4 * outsideDiameter
                outsideSlope = (outsideDiameter - outsideVertical) / 2.0
                insideDiameter = outsideDiameter - 2 * width
                insideVertical = 0.4 * insideDiameter
                insideSlope = (insideDiameter - insideVertical) / 2.0
                x1 = - width / 2.0
                y1 = outsideDiameter + delta * i - width / 2.0
                x2 = x1 - outsideVertical / 2.0 + width / 2.0
                y2 = y1
                x3 = x2 - outsideSlope
                y3 = y2 - outsideSlope
                x4 = x3
                y4 = y3 - (outsideVertical - delta / 2.0)
                x5 = x4 + (outsideSlope - delta / 2.0)
                y5 = y4 - (outsideSlope - delta / 2.0)
                x6 = x5 + (outsideVertical / 2.0 + delta / 2.0) - width / 2.0
                y6 = y5
                x7 = x6
                y7 = y6 + width
                x8 = x7 - (insideVertical / 2.0 + delta / 2.0) + width / 2.0
                y8 = y7
                x9 = x8 - (insideSlope - delta / 2.0)
                y9 = y8 + (insideSlope - delta / 2.0)
                x10 = x9
                y10 = y9 + (insideVertical - delta / 2.0)
                x11 = x10 + insideSlope
                y11 = y10 + insideSlope
                x12 = x11 + insideVertical / 2.0 - width / 2.0
                y12 = y11
                vertexes = list(x1:y1 x2:y2 x3:y3 x4:y4 x5:y5 x6:y6 x7:y7 x8:y8 x9:y9 x10:y10 x11:y11 x12:y12)
                dbCreatePolygon(
                    pcCellView
                    list("METAL5" "drawing")
                    vertexes
                )
            )
        )

        ; Drawing protect and no-dummy area
        let((centerDiameter protectDiameter side slope residue x1 x2 x3 x4 x5 x6 x7 x8 y1 y2 y3 y4 y5 y6 y7 y8 vertexes)
            centerDiameter = diameter - width
            protectDiameter = centerDiameter + 2 * leadLength
            side = 0.4 * protectDiameter
            slope = (protectDiameter - side) / 2.0
            residue = ceiling(slope) - slope
            x1 = side / 2.0
            y1 = -leadLength
            x2 = x1 + slope + residue
            y2 = y1 + slope + residue
            x3 = x2
            y3 = y2 + side - 2 * residue
            x4 = x3 - slope - residue
            y4 = y3 + slope + residue
            x5 = x4 - side
            y5 = y4
            x6 = x5 - slope - residue
            y6 = y5 - slope - residue
            x7 = x6
            y7 = y6 - side + 2 * residue
            x8 = x7 + slope + residue
            y8 = y7 - slope - residue
            vertexes = list(x1:y1 x2:y2 x3:y3 x4:y4 x5:y5 x6:y6 x7:y7 x8:y8)
            foreach(Layer list("PROTECT" "NODMYAL" "NODMYACT")
                dbCreatePolygon(
                    pcCellView
                    list(Layer "drawing")
                    vertexes
                )
            )
        )

        ; Drawing lead line of south side
        dbCreatePath(
                pcCellView
                list("METAL5" "drawing")
                list(0:width/2.0 0:-leadLength)
                width
            )

        ; Drawing lead line of north side
        let((centerDiameter viaArrayTop viaArrayUnder northLeadStart northLeadEnd)
            centerDiameter = diameter - width
            viaArrayTop = floor(width / 0.72)
            viaArrayUnder = floor(width / 0.56)
            northLeadStart = centerDiameter - turns * delta - width / 2.0
            northLeadEnd = centerDiameter + leadLength
            if(leadLine? then
                dbCreatePath(
                    pcCellView
                    list("METAL4" "drawing")
                    list(0:northLeadStart 0:centerDiameter+delta+width/2.0)
                    width
                )
                dbCreatePath(
                    pcCellView
                    list("METAL5" "drawing")
                    list(0:centerDiameter+space+width/2.0 0:northLeadEnd)
                    width
                )
                dbCreateVia(
                    pcCellView
                    techFindViaDefByName(techGetTechFile(pcCellView) "TopVia")
                    list(0 northLeadStart+width/2.0)
                    "R0"
                    list(list("cutRows" viaArrayTop) list("cutColumns" viaArrayTop))
                )
                dbCreateVia(
                    pcCellView
                    techFindViaDefByName(techGetTechFile(pcCellView) "TopVia")
                    list(0 centerDiameter+delta)
                    "R0"
                    list(list("cutRows" viaArrayTop) list("cutColumns" viaArrayTop))
                )
            )
        )

        ; Drawing ground wall of west side
        if(groundWall? then
            let((centerDiameter protectDiameter outsideDiameter outsideVertical outsideSlope insideDiameter insideVertical insideSlope x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 vertexes)
                centerDiameter = diameter - width
                protectDiameter = centerDiameter + 2 * leadLength
                outsideDiameter = protectDiameter + wallWidth
                outsideVertical = 0.4 * outsideDiameter
                outsideSlope = (outsideDiameter - outsideVertical) / 2.0
                insideDiameter = outsideDiameter - 2 * wallWidth
                insideVertical = 0.4 * insideDiameter
                insideSlope = (insideDiameter - insideVertical) / 2.0
                x1 = - tlineWidth / 2.0
                y1 = outsideDiameter - leadLength - wallWidth / 2.0
                x2 = x1 - outsideVertical / 2.0 + tlineWidth / 2.0
                y2 = y1
                x3 = x2 - outsideSlope
                y3 = y2 - outsideSlope
                x4 = x3
                y4 = y3 - outsideVertical
                x5 = x4 + outsideSlope
                y5 = y4 - outsideSlope
                x6 = - tlineWidth / 2.0
                y6 = y5
                x7 = x6
                y7 = y6 + wallWidth
                x8 = x7 - insideVertical / 2.0 + tlineWidth / 2.0
                y8 = y7
                x9 = x8 - insideSlope
                y9 = y8 + insideSlope
                x10 = x9
                y10 = y9 + insideVertical
                x11 = x10 + insideSlope
                y11 = y10 + insideSlope
                x12 = - tlineWidth / 2.0
                y12 = y11
                vertexes = list(x1:y1 x2:y2 x3:y3 x4:y4 x5:y5 x6:y6 x7:y7 x8:y8 x9:y9 x10:y10 x11:y11 x12:y12)
                foreach(metalLayer list("METAL1" "METAL2" "METAL3" "METAL4" "METAL5")
                    dbCreatePolygon(
                        pcCellView
                        list(metalLayer "drawing")
                        vertexes
                    )
                )
            )
        )

        ; Drawing ground wall of east side
        if(groundWall? then
            let((centerDiameter protectDiameter outsideDiameter outsideVertical outsideSlope insideDiameter insideVertical insideSlope x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 vertexes)
                centerDiameter = diameter - width
                protectDiameter = centerDiameter + 2 * leadLength
                outsideDiameter = protectDiameter + wallWidth
                outsideVertical = 0.4 * outsideDiameter
                outsideSlope = (outsideDiameter - outsideVertical) / 2.0
                insideDiameter = outsideDiameter - 2 * wallWidth
                insideVertical = 0.4 * insideDiameter
                insideSlope = (insideDiameter - insideVertical) / 2.0
                x1 = tlineWidth / 2.0
                y1 = outsideDiameter - leadLength - wallWidth / 2.0
                x2 = x1 + outsideVertical / 2.0 - tlineWidth / 2.0
                y2 = y1
                x3 = x2 + outsideSlope
                y3 = y2 - outsideSlope
                x4 = x3
                y4 = y3 - outsideVertical
                x5 = x4 - outsideSlope
                y5 = y4 - outsideSlope
                x6 = tlineWidth / 2.0
                y6 = y5
                x7 = x6
                y7 = y6 + wallWidth
                x8 = x7 + insideVertical / 2.0 - tlineWidth / 2.0
                y8 = y7
                x9 = x8 + insideSlope
                y9 = y8 + insideSlope
                x10 = x9
                y10 = y9 + insideVertical
                x11 = x10 - insideSlope
                y11 = y10 + insideSlope
                x12 = tlineWidth / 2.0
                y12 = y11
                vertexes = list(x1:y1 x2:y2 x3:y3 x4:y4 x5:y5 x6:y6 x7:y7 x8:y8 x9:y9 x10:y10 x11:y11 x12:y12)
                foreach(metalLayer list("METAL1" "METAL2" "METAL3" "METAL4" "METAL5")
                    dbCreatePolygon(
                        pcCellView
                        list(metalLayer "drawing")
                        vertexes
                    )
                )
            )
        )
    )
)
