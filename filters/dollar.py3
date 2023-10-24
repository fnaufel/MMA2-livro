#!/usr/bin/env python3
import panflute as pf

"""
Pandoc filter that replaces \(...\) with $...$
Other output formats are unaffected.
The hl.py3 filter only works if this filter runs first.
"""


def dollar(e, doc):
    if  doc.format=='latex' and type(e) == pf.Math and e.format == 'InlineMath':
        contents = e.text
        return pf.RawInline('$' + contents + '$', format='latex')


if __name__ == "__main__":
    pf.toJSONFilter(dollar)
