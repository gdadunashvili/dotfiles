import sys
import re

SQUARE_CIATATION=re.compile(r'\[[a-zA-Z0-9!@#$%^&*()_+\-–—={};:"\\|,.<>\/?]*\]')
# ROUND_CIATATION =re.compile(r'\([a-zA-Z0-9!@#$%^&*_+\-–—={};:"\\|,.<>\/?]*\)')
ROUND_CIATATION =re.compile(r'\([0-9]+[a-zA-Z0-9!@#$%^&*_+\-–—={};:"\\|,.<>\/?]*\)')
FOOTNOTE_NUMBER=re.compile(r'([a-zA-Z]+)(\d+[,\d]*)')

def  clean_non_ascii(text:str):
    text = text.encode('ascii',errors='ignore')
    return text.decode()

def  ignore_citations(text:str):
    # return text.replace(SQUARE_CIATATION,  '')
    # return str(SQUARE_CIATATION.sub('', text))
    return str(ROUND_CIATATION.sub('', text))

def drop_the_numbers(match_obj: re.Match):
    return match_obj.group(1)


def ignore_footnotes(text:str):
    # re.sub(r"(house|the house)", r"**\1**", mystring)
    # return str(re.sub(FOOTNOTE_NUMBER,r"\1", text))
    return str(re.sub(FOOTNOTE_NUMBER, drop_the_numbers, text))


def footnote_test():
    test_text=r'size3 facilitates adaptation to the local environ- ment4,5, which is critical for optimal growth6.'
    test_text = ignore_footnotes(test_text)
    print(test_text)

def round_citation_test():
    test_str=r'structure (trans-Golgi network). This basic morphology is highly conserved among eukaryotic species, with a few exceptions (1, 2).'
    test_str=ignore_citations(test_str)
    print(test_str)

def main():
    text =  ' '.join(sys.argv[1:])
    text = ignore_footnotes(text)
    text = clean_non_ascii(text)
    text = ignore_citations(text)
    print(text)


if __name__=='__main__':
    main()
    # round_citation_test()
    # footnote_test()

