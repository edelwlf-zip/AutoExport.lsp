(defun C:Plotter ( / paperChoice paperName printerName
                        dwgPath dwgName pdfPath )

  ;; ----------------------------------------------------------------
  ;; 1. Paper size selection
  ;; ----------------------------------------------------------------
  (princ "\nSelect paper size:")
  (princ "\n  1 - ISO Full Bleed A0 (841 x 1189 mm)")
  (princ "\n  2 - ISO Full Bleed A1 (594 x 841 mm)")
  (princ "\n  3 - ISO Full Bleed A2 (420 x 594 mm)")
  (princ "\n  4 - ISO Full Bleed A3 (297 x 420 mm)")
  (initget "1 2 3 4")
  (setq paperChoice (getkword "\nEnter choice [1/2/3/4] <1>: "))
  (if (null paperChoice) (setq paperChoice "1"))

  (cond
    ((= paperChoice "1") (setq paperName "ISO_full_bleed_A0_(841.00_x_1189.00_MM)"))
    ((= paperChoice "2") (setq paperName "ISO_full_bleed_A1_(594.00_x_841.00_MM)"))
    ((= paperChoice "3") (setq paperName "ISO_full_bleed_A2_(420.00_x_594.00_MM)"))
    ((= paperChoice "4") (setq paperName "ISO_full_bleed_A3_(297.00_x_420.00_MM)"))
  )

  ;; ----------------------------------------------------------------
  ;; 2. Build PDF path: same folder and base name as the DWG
  ;;    e.g. TESTE.dwg  ->  TESTE.pdf  (in same folder)
  ;; ----------------------------------------------------------------
  (setq dwgPath (getvar "DWGPREFIX")
        dwgName (vl-filename-base (getvar "DWGNAME"))
        pdfPath (strcat dwgPath dwgName ".pdf")
  )
  (princ (strcat "\nOutput PDF: " pdfPath))

  ;; ----------------------------------------------------------------
  ;; 3. Plotter name
  ;; ----------------------------------------------------------------
  (setq printerName "DWG To PDF.pc3")

  ;; ----------------------------------------------------------------
  ;; 4. Run -PLOT with correct prompt sequence
  ;; ----------------------------------------------------------------
  (command "_.-PLOT"
    "_Yes"           ; 1.  Detailed plot configuration?
    ""               ; 2.  Layout name (blank = current)
    printerName      ; 3.  Output device
    paperName        ; 4.  Paper size
    "_Millimeters"   ; 5.  Paper units
    "_Landscape"     ; 6.  Drawing orientation
    "_No"            ; 7.  Plot upside down?
    "_Extents"       ; 8.  Plot area
    "_Fit"           ; 9.  Plot scale: Fit
    "_Center"        ; 10. Plot offset: Center
    "_Yes"           ; 11. Plot with plot styles?
    "acad.ctb"       ; 12. Plot style table
    "_Yes"           ; 13. Plot with lineweights?
    "_No"            ; 14. Scale lineweights with plot scale?
    "_No"            ; 15. Plot paper space first?
    "_No"            ; 16. Hide paperspace objects?
    pdfPath          ; 17. Enter file name  <-- drawing name PDF
    "_AsDisplayed"   ; 18. Shade plot
    "_Maximum"       ; 19. Shade plot quality
    "1"              ; 20. Number of copies
    "_No"            ; 21. Save changes to page setup?
    "_Yes"           ; 22. Proceed with plot?
  )

  (princ (strcat "\nDone. PDF: " pdfPath))
  (princ)
)

(princ "\nPLOT_SHEET loaded. Type PLOT_SHEET to run.")
(princ)
