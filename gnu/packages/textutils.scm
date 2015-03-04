;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2015 Taylan Ulrich Bayırlı/Kammer <taylanbayirli@gmail.com>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (gnu packages textutils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages python))

(define-public recode
  (package
    (name "recode")
    ;; Last beta release (3.7-beta2) is from 2008; last commit from Feb 2014.
    ;; So we use that commit instead.
    (version "3.7.0.201402")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/pinard/Recode.git")
             (commit "2d7092a9999194fc0e9449717a8048c8d8e26c18")))
       (sha256
        (base32 "1wssv8z6g3ryrw33sksz4rjhlnhgvvdqszw1ggl4rcwks34n86zm"))))
    (build-system gnu-build-system)
    (native-inputs `(("python" ,python-2)))
    (arguments
     '(#:phases
       (alist-cons-before
        'check 'fix-setup-py
        (lambda _
          (substitute* "tests/setup.py"
            (("([[:space:]]*)include_dirs=.*" all space)
             (string-append all space "library_dirs=['../src/.libs'],\n"))))
        %standard-phases)))
    (home-page "https://github.com/pinard/Recode")
    (synopsis "Text encoding converter")
    (description "The Recode library converts files between character sets and
usages.  It recognises or produces over 200 different character sets (or about
300 if combined with an iconv library) and transliterates files between almost
any pair.  When exact transliteration are not possible, it gets rid of
offending characters or falls back on approximations.  The recode program is a
handy front-end to the library.")
    (license license:gpl2+)))

(define-public enca
  (package
    (name "enca")
    (version "1.16")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/nijel/enca/archive/" version ".tar.gz"))
       (sha256
        (base32 "1xik00x0yvhswsw2isnclabhv536xk1s42cf5z54gfbpbhc7ni8l"))))
    (build-system gnu-build-system)
    (inputs `(("recode" ,recode)))
    (home-page "https://github.com/nijel/enca")
    (synopsis "Text encoding detection tool")
    (description "Enca (Extremely Naive Charset Analyser) consists of libenca,
an encoding detection library, and enca, a command line frontend, integrating
libenca and several charset conversion libraries and tools.")
    (license license:gpl2)))
