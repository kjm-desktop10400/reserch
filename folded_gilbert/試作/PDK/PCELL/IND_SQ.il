; ----------------------------------------------------------------------------
; Parameterized cell of square spiral inductor for ROHM 180nm CMOS Technology
; Written by Keisuke Kawahara <7320529@ed.tus.ac.jp>
; ----------------------------------------------------------------------------

pcDefinePCell(
    list(
        ddGetObj("ROHMLIB")
        "IND_SQ"
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

    let((delta leadLength pcellViaArray)
        delta = space + width
        leadLength = ceiling(leadLineLength + width / 2.0)
        pcellViaArray = dbOpenCellViewByType(pcCellView->libName "VIA_ARRAY" "layout")

        ; Drawing east side of spiral
        let((diameterCenter x1 x2 x3 x4 y1 y2 y3 y4 vertexes)
            for(i 0 turns
                diameterCenter = diameter - width - 2.0 * i * delta
                x1 = - width / 2.0
                y1 = delta * i
                x2 = x1 + diameterCenter / 2.0 + width / 2.0
                y2 = y1
                x3 = x2
                y3 = y2 + diameterCenter
                x4 = x3 - diameterCenter / 2.0 - width / 2.0
                y4 = y3
                vertexes = list(x1:y1 x2:y2 x3:y3 x4:y4)
                dbCreatePath(
                    pcCellView
                    list("METAL5" "drawing")
                    vertexes
                    width
                )
            )
        )


        ; Drawing west side of spiral
        let((diameterCenter x1 x2 x3 x4 y1 y2 y3 y4 vertexes)
            for(i 0 turns-1
                diameterCenter = diameter - width - 2.0 * i * delta
                x1 = - width / 2.0
                y1 = diameterCenter + delta * i
                x2 = x1 - diameterCenter / 2.0 + width / 2.0
                y2 = y1
                x3 = x2
                y3 = y2 - diameterCenter + delta
                x4 = x3 + diameterCenter / 2.0 - width / 2.0
                y4 = y3
                vertexes = list(x1:y1 x2:y2 x3:y3 x4:y4)
                dbCreatePath(
                    pcCellView
                    list("METAL5" "drawing")
                    vertexes
                    width
                )
            )
        )

        ; Drawing protect and no-dummy area
        let((diameterCenter diameterProtect residue x1 x2 x3 x4 y1 y2 y3 y4 vertexes)
            diameterCenter = diameter - width
            diameterProtect = diameterCenter + 2 * leadLength
            x1 = diameterProtect / 2.0
            y1 = -leadLength
            x2 = x1
            y2 = y1 + diameterProtect
            x3 = x2 - diameterProtect
            y3 = y2
            x4 = x3
            y4 = y3 - diameterProtect
            vertexes = list(x1:y1 x2:y2 x3:y3 x4:y4)
            foreach(Layer list("PROTECT" "NODMYAL" "NODMYACT")
                dbCreatePolygon(
                    pcCellView
                    list(Layer "drawing")
                    vertexes
                )
            )
        )

        ; Drawing lead line of south side
        if(leadLine? then
            dbCreatePath(
                pcCellView
                list("METAL5" "drawing")
                list(0:width/2.0 0:-leadLength)
                width
            )
        )

        ; Drawing lead line of north side
        let((diameterCenter viaArrayTop viaArrayUnder northLeadStart northLeadEnd)
            diameterCenter = diameter - width
            viaArrayTop = floor(width / 0.72)
            viaArrayUnder = floor(width / 0.56)
            northLeadStart = diameterCenter - turns * delta - width / 2.0
            northLeadEnd = diameterCenter + leadLength
            if(leadLine? then
                dbCreatePath(
                    pcCellView
                    list("METAL4" "drawing")
                    list(0:northLeadStart 0:diameterCenter+delta+width/2.0)
                    width
                )
                dbCreatePath(
                    pcCellView
                    list("METAL5" "drawing")
                    list(0:diameterCenter+space+width/2.0 0:northLeadEnd)
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
                    list(0 diameterCenter+delta)
                    "R0"
                    list(list("cutRows" viaArrayTop) list("cutColumns" viaArrayTop))
                )
            )
        )

        ; Drawing ground wall
        if(groundWall? then
            let((diameterCenter diameterProtect x1 x2 x3 x4 y1 y2 y3 y4 vertexesEast vertexesWest wallWidth tlineWidth)
                diameterCenter = diameter - width
                diameterProtect = diameterCenter + 2 * leadLength
                tlineWidth = 28.8
                wallWidth = 6
                x1 = diameterProtect / 2.0
                y1 = -leadLength
                x2 = x1
                y2 = y1 + diameterProtect
                x3 = x2 - diameterProtect
                y3 = y2
                x4 = x3
                y4 = y3 - diameterProtect
                vertexesEast = list(tlineWidth/2.0:y1 x1:y1 x2:y2 tlineWidth/2.0:y2)
                vertexesWest = list(-tlineWidth/2.0:y3 x3:y3 x4:y4 -tlineWidth/2.0:y4)
                foreach(metalLayer list("METAL1" "METAL2" "METAL3" "METAL4" "METAL5")
                    dbCreatePath(
                        pcCellView
                        list(metalLayer "drawing")
                        vertexesEast
                        wallWidth
                    )
                    dbCreatePath(
                        pcCellView
                        list(metalLayer "drawing")
                        vertexesWest
                        wallWidth
                    )
                )
                ; Create via array
                dbCreateParamInst(pcCellView pcellViaArray nil 0:0 "R0" 1 list(
                    list("llx" "float" ceiling(tlineWidth/2.0+6.2))
                    list("lly" "float" y1-wallWidth/2.0)
                    list("urx" "float" floor(x1-wallWidth/2.0))
                    list("ury" "float" y1+wallWidth/2.0)
                    )
                )
                dbCreateParamInst(pcCellView pcellViaArray nil 0:0 "R0" 1 list(
                    list("llx" "float" ceiling(tlineWidth/2.0+6.2))
                    list("lly" "float" y2-wallWidth/2.0)
                    list("urx" "float" floor(x2-wallWidth/2.0))
                    list("ury" "float" y2+wallWidth/2.0)
                    )
                )
                dbCreateParamInst(pcCellView pcellViaArray nil 0:0 "R0" 1 list(
                    list("llx" "float" x2-wallWidth/2.0)
                    list("lly" "float" y1+wallWidth/2.0)
                    list("urx" "float" x2+wallWidth/2.0)
                    list("ury" "float" y2-wallWidth/2.0)
                    )
                )
                dbCreateParamInst(pcCellView pcellViaArray nil 0:0 "R0" 1 list(
                    list("llx" "float" ceiling(-x1+wallWidth/2.0))
                    list("lly" "float" y1-wallWidth/2.0)
                    list("urx" "float" floor(-tlineWidth/2.0-6.2))
                    list("ury" "float" y1+wallWidth/2.0)
                    )
                )
                dbCreateParamInst(pcCellView pcellViaArray nil 0:0 "R0" 1 list(
                    list("llx" "float" ceiling(-x2+wallWidth/2.0))
                    list("lly" "float" y2-wallWidth/2.0)
                    list("urx" "float" floor(-tlineWidth/2.0-6.2))
                    list("ury" "float" y2+wallWidth/2.0)
                    )
                )
                dbCreateParamInst(pcCellView pcellViaArray nil 0:0 "R0" 1 list(
                    list("llx" "float" -x2-wallWidth/2.0)
                    list("lly" "float" y1+wallWidth/2.0)
                    list("urx" "float" -x2+wallWidth/2.0)
                    list("ury" "float" y2-wallWidth/2.0)
                    )
                )
            )
        )

    t
    )
)