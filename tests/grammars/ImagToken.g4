/*
 * Copyright (c) 2017 Renata Hodovan, Akos Kiss.
 *
 * Licensed under the BSD 3-Clause License
 * <LICENSE.rst or https://opensource.org/licenses/BSD-3-Clause>.
 * This file may not be copied, modified, or distributed except
 * according to those terms.
 */

/*
 * This test checks whether imaginary tokens are handled correctly.
 */

// TEST-PROCESS: {grammar}.g4 -o {tmpdir}
// TEST-GENERATE: -p {grammar}Unparser -l {grammar}Unlexer -r start -o {tmpdir}/{grammar}%d.txt
// TEST-ANTLR: {grammar}.g4 -o {tmpdir}

grammar ImagToken;

@lexer::members {
def REDEFINED(self):
    return self.create_node(UnlexerRule(name='REDEFINED', src='redefined'))
}

tokens { IMAG, REDEFINED }

start
  : IMAG {assert current.last_child.name == 'IMAG' and current.last_child.src is None} REDEFINED {assert current.last_child.src == 'redefined'}
  ;
