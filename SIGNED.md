##### Signed by https://keybase.io/max
```
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAABCgAGBQJUpp6CAAoJEJgKPw0B/gTfWB8IAKTF4fIRThivEgKHTI5J5Ikh
dqJkoo393PAJ36qaU6V/P+WLIA/7OrHGF7dsAb70A4vGvg2ymq0t3FnzonEcuY/R
274HSNSmujO3SZT2RSzuAB9NO/lM8VDyiUZ05aY2Y//giQ9SkWeXOcrfk1sEqlK5
YNpBFPKWA2WGBeqH/ULGs+8p9uK5EpJaZANzrBJrz8U/CvFZa+SFxsidAN7kwyut
W2SMjTQZk3d49+aO1X4HAzljBGlpxDw5UyrRVYs0ZrDW2xB49TnEvae8HRxS+RQj
mYjIHXy3+ZkyUbfn4mC1qcpAqN8acILkp6knbLMkZop2SANdFdBGHeJmX6ManQg=
=jXlx
-----END PGP SIGNATURE-----

```

<!-- END SIGNATURES -->

### Begin signed statement 

#### Expect

```
size   exec  file             contents                                                        
             ./                                                                               
15             .gitignore     dd1fc419aaedd1f95754c9b7a1f3642f75c74ce77921ffcbde0e32abcbc37900
804            Cakefile       156682e8a84c2c075e835d281f64ef17fd268fa6a5d2fe3b8677a40dcec18f05
1419           README.md      7c61c7336b55251d644669424ea00987b2f8f7836315e0246d1393abfbbd4aa7
1375           cmd.js         386ca58dada0209c0bc7d6219deae83749befbb16441b29f50cfb7f4c22db22e
               lib/                                                                           
13435            server.js    5c694cb7593549dba7e9b48ccdb3f22d98fab87b761d5978e4bd89c56d3f3a69
578            package.json   cdbde6713ee1366529c81559656debac32d90e285b47a67319d0e4c100f49b91
               src/                                                                           
4617             server.iced  128704c5fc8b0c82e429f6fb2f08345d721b263f45a6327f67610bb227b55e9a
```

#### Ignore

```
/SIGNED.md
```

#### Presets

```
git      # ignore .git and anything as described by .gitignore files
dropbox  # ignore .dropbox-cache and other Dropbox-related files    
kb       # ignore anything as described by .kbignore files          
```

<!-- summarize version = 0.0.9 -->

### End signed statement

<hr>

#### Notes

With keybase you can sign any directory's contents, whether it's a git repo,
source code distribution, or a personal documents folder. It aims to replace the drudgery of:

  1. comparing a zipped file to a detached statement
  2. downloading a public key
  3. confirming it is in fact the author's by reviewing public statements they've made, using it

All in one simple command:

```bash
keybase dir verify
```

There are lots of options, including assertions for automating your checks.

For more info, check out https://keybase.io/docs/command_line/code_signing