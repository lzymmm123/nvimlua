return {
    s("fn",{
      t({"func"}),
      t({"("}),
      i(1,'val type'),
      t({") "}),
      i(2,"funcname"),
      t({"("}),
      i(3,"arguments"),
      t({") "}),
      i(4,"return_type "),
      t({"{", "\t"}),
      i(0),
      t({"","}"}),
    }),

    s("ifnil",{
      t("if "),
      i(1,"err"),
      t({" != nil {","\t"}),
      i(0,"return"),
      t({"","}"}),
    })
}
