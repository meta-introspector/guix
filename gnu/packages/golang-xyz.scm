;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2018, 2019 Leo Famulari <leo@famulari.name>
;;; Copyright © 2022 Dominic Martinez <dom@dominicm.dev>
;;; Copyright © 2023 Benjamin <benjamin@uvy.fr>
;;; Copyright © 2023 Thomas Ieong <th.ieong@free.fr>
;;; Copyright © 2024 Artyom V. Poptsov <poptsov.artyom@gmail.com>
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

(define-module (gnu packages golang-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system go)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages golang-check)
  #:use-module (gnu packages golang-crypto))

;;; Commentary:
;;;
;;; Nomad Golang modules (libraries) are welcome here.
;;;
;;; Please: Try to add new module packages in alphabetic order.
;;;
;;; Code:

(define-public go-github-com-anmitsu-go-shlex
  (package
    (name "go-github-com-anmitsu-go-shlex")
    (version "0.0.0-20200514113438-38f4b401e2be")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/anmitsu/go-shlex")
               (commit (go-version->git-ref version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "17iz68yzbnr7y4s493asbagbv79qq8hvl2pkxvm6bvdkgphj8w1g"))))
    (build-system go-build-system)
    (arguments '(#:import-path "github.com/anmitsu/go-shlex"))
    (home-page "https://github.com/anmitsu/go-shlex")
    (synopsis "Simple shell-like lexical analyzer for Go")
    (description "This package provides a simple lexical analyzer to parse
shell-like commands.")
    (license license:expat)))

(define-public go-github-com-armon-go-radix
  (package
    (name "go-github-com-armon-go-radix")
    (version "1.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/armon/go-radix")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1m1k0jz9gjfrk4m7hjm7p03qmviamfgxwm2ghakqxw3hdds8v503"))))
    (build-system go-build-system)
    (arguments '(#:import-path "github.com/armon/go-radix"))
    (home-page "https://github.com/armon/go-radix")
    (synopsis "Go implementation of Radix trees")
    (description "This package provides a single @code{Tree} implementation,
optimized for sparse nodes of
@url{http://en.wikipedia.org/wiki/Radix_tree,radix tree}.")
    (license license:expat)))

(define-public go-github-com-cyberdelia-go-metrics-graphite
  (package
    (name "go-github-com-cyberdelia-go-metrics-graphite")
    (version "0.0.0-20161219230853-39f87cc3b432")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/cyberdelia/go-metrics-graphite")
               (commit (go-version->git-ref version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1nnpwryw8i110laffyavvhx38gcd1jnpdir69y6fxxzpx06d094w"))))
    (build-system go-build-system)
    (propagated-inputs
     (list go-github-com-rcrowley-go-metrics))
    (arguments
     '(#:tests? #f ; Tests require network interface access
       #:import-path "github.com/cyberdelia/go-metrics-graphite"))
    (home-page "https://github.com/cyberdelia/go-metrics-graphite")
    (synopsis "Graphite client for go-metrics")
    (description "This package provides a reporter for the
@url{https://github.com/rcrowley/go-metrics,go-metrics} library which posts
metrics to Graphite.")
    (license license:bsd-2)))

(define-public go-github-com-djherbis-atime
  (package
    (name "go-github-com-djherbis-atime")
    (version "1.1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/djherbis/atime")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0xsz55zpihd9wyrj6qvm3miqzb6x3mnp5apzs0dx1byndhb8adpq"))))
    (build-system go-build-system)
    (arguments
     '(#:import-path "github.com/djherbis/atime"))
    (home-page "https://github.com/djherbis/atime")
    (synopsis "Access Times for files")
    (description "Package atime provides a platform-independent way to get
atimes for files.")
    (license license:expat)))

(define-public go-github-com-gabriel-vasile-mimetype
  (package
    (name "go-github-com-gabriel-vasile-mimetype")
    (version "1.4.3")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/gabriel-vasile/mimetype")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "11swnjczhrza0xi8q2wlk056nnbcghm44vqs52zfv6rwqvy6imhj"))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.20
      #:import-path "github.com/gabriel-vasile/mimetype"
      #:phases #~(modify-phases %standard-phases
                   (add-before 'check 'add-supported-mimes-md
                     (lambda* (#:key import-path #:allow-other-keys)
                       ;; This file needs to be available for writing during the
                       ;; tests otherwise they will fail.
                       (let ((file (format #f "src/~a/supported_mimes.md"
                                           import-path)))
                         (invoke "touch" file)
                         (chmod file #o644)))))))
    (propagated-inputs (list go-golang-org-x-net))
    (home-page "https://github.com/gabriel-vasile/mimetype")
    (synopsis "Golang library for media type and file extension detection")
    (description
     "This package provides a Golang module that uses magic number signatures
to detect the MIME type of a file.

Main features:
@itemize
@item Fast and precise MIME type and file extension detection.
@item Supports
@url{https://github.com/gabriel-vasile/mimetype/blob/master/supported_mimes.md,
many MIME types}.
@item Allows to
@url{https://pkg.go.dev/github.com/gabriel-vasile/mimetype#example-package-Extend,
extend} with other file formats.
@item Common file formats are prioritized.
@item
@url{https://pkg.go.dev/github.com/gabriel-vasile/mimetype#example-package-TextVsBinary,
Differentiation between text and binary files}.
@item Safe for concurrent usage.
@end itemize")
    (license license:expat)))

(define-public go-github-com-matryer-try
  (package
    (name "go-github-com-matryer-try")
    (version "1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/matryer/try")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "15f0m5ywihivnvwzcw0mh0sg27aky9rkywvxqszxka9q051qvsmy"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/matryer/try"
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'fix-tests
            (lambda* (#:key import-path #:allow-other-keys)
              (substitute* (string-append "src/" import-path
                                          "/try_test.go")
                (("var value string")
                 "")
                (("value, err = SomeFunction\\(\\)")
                 "_, err = SomeFunction()")))))))
    (native-inputs
     (list go-github-com-cheekybits-is))
    (home-page "https://github.com/matryer/try")
    (synopsis "Simple idiomatic retry package for Go")
    (description "This package provides an idiomatic Go retry module.")
    (license license:expat)))

(define-public go-github-com-miekg-dns
  (package
    (name "go-github-com-miekg-dns")
    (version "1.1.48")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/miekg/dns")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "14m4wnbgmc1prj4ds1fsz1nwb1awaq365lhbp8clzsidxmhjf3hl"))))
    (build-system go-build-system)
    (arguments '(#:import-path "github.com/miekg/dns"))
    (propagated-inputs
     (list go-golang-org-x-tools
           go-golang-org-x-sys
           go-golang-org-x-sync
           go-golang-org-x-net))
    (home-page "https://github.com/miekg/dns")
    (synopsis "Domain Name Service library in Go")
    (description
      "This package provides a fully featured interface to the @acronym{DNS,
Domain Name System}.  Both server and client side programming is supported.
The package allows complete control over what is sent out to the @acronym{DNS,
Domain Name Service}.  The API follows the less-is-more principle, by
presenting a small interface.")
    (license license:bsd-3)))

(define-public go-github-com-nats-io-nats-go
  (package
    (name "go-github-com-nats-io-nats-go")
    (version "1.32.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nats-io/nats.go")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "08b3n5mdpxvn9hipz0j001bp5r67i43cqji9x9dyzikypqdfg38k"))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.20
      #:import-path "github.com/nats-io/nats.go"))
    (propagated-inputs (list go-golang-org-x-text
                         go-github-com-nats-io-nuid
                         go-github-com-nats-io-nkeys
                         go-github-com-klauspost-compress))
    (home-page "https://github.com/nats-io/nats.go")
    (synopsis "Go Client for NATS server")
    (description
     "This package provides a Go client for the NATS messaging system.")
    (license license:asl2.0)))

(define-public go-github-com-nats-io-nuid
  (package
    (name "go-github-com-nats-io-nuid")
    (version "1.0.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nats-io/nuid")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "11zbhg4kds5idsya04bwz4plj0mmiigypzppzih731ppbk2ms1zg"))))
    (build-system go-build-system)
    (arguments
     '(#:import-path "github.com/nats-io/nuid"))
    (home-page "https://github.com/nats-io/nuid")
    (synopsis "Go library implementing identifier generator for NATS ecosystem")
    (description
     "This package provides a unique identifier generator that is high performance,
very fast, and tries to be entropy pool friendly.")
    (license license:asl2.0)))

(define-public go-github-com-nbrownus-go-metrics-prometheus
  (package
    (name "go-github-com-nbrownus-go-metrics-prometheus")
    (version "0.0.0-20210712211119-974a6260965f")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/nbrownus/go-metrics-prometheus")
               (commit (go-version->git-ref version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1kl9l08aas544627zmhkgp843qx94sxs4inxm20nw1hx7gp79dz0"))))
    (build-system go-build-system)
    (arguments '(#:import-path "github.com/nbrownus/go-metrics-prometheus"))
    (propagated-inputs
     (list go-github-com-stretchr-testify
           go-github-com-rcrowley-go-metrics
           go-github-com-prometheus-client-golang))
    (home-page "https://github.com/nbrownus/go-metrics-prometheus")
    (synopsis "Prometheus support for go-metrics")
    (description "This package provides a reporter for the @code{go-metrics}
library which posts the metrics to the Prometheus client registry and just
updates the registry.")
    (license license:asl2.0)))

(define-public go-github-com-prometheus-client-model
  (let ((commit "14fe0d1b01d4d5fc031dd4bec1823bd3ebbe8016")
        (revision "2"))
    (package
      (name "go-github-com-prometheus-client-model")
      (version (git-version "0.0.2" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/prometheus/client_model")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0zdmk6rbbx39cvfz0r59v2jg5sg9yd02b4pds5n5llgvivi99550"))))
      (build-system go-build-system)
      (arguments
       '(#:import-path "github.com/prometheus/client_model"
         #:tests? #f
         #:phases
         (modify-phases %standard-phases
           ;; Source-only package
           (delete 'build))))
      (propagated-inputs
       (list go-github-com-golang-protobuf-proto))
      (synopsis "Data model artifacts for Prometheus")
      (description "This package provides data model artifacts for Prometheus.")
      (home-page "https://github.com/prometheus/client_model")
      (license license:asl2.0))))

(define-public go-github-com-skip2-go-qrcode
  (package
    (name "go-github-com-skip2-go-qrcode")
    (version "0.0.0-20200617195104-da1b6568686e")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/skip2/go-qrcode")
             (commit (go-version->git-ref version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0pghd6y2x8a5fqy4rjn4d8j5jcslb236naycdza5an7vyvinsgs9"))
       (patches (search-patches "go-github-com-skip2-go-qrcode-fix-tests.patch"))))
    (build-system go-build-system)
    (arguments '(#:import-path "github.com/skip2/go-qrcode"))
    (home-page "https://github.com/skip2/go-qrcode")
    (synopsis "QR code encoder")
    (description "This package provides a QR code encoder for the Goloang.")
    (license license:expat)))

(define-public go-github-com-songgao-water
  (package
    (name "go-github-com-songgao-water")
    (version "0.0.0-20200317203138-2b4b6d7c09d8")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/songgao/water")
               (commit (go-version->git-ref version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1k5aildfszp6x66jzar4y36lic8ijkb5020hfaivpvq3bnwdiikl"))))
    (build-system go-build-system)
    (arguments '(#:tests? #f ; Tests require network interface access
                 #:import-path "github.com/songgao/water"))
    (home-page "https://github.com/songgao/water")
    (synopsis "Simple network TUN/TAP library")
    (description
      "This package provides a simple TUN/TAP interface library for Go that
efficiently works with standard packages like @code{io}, @code{bufio}, etc..
Use waterutil with it to work with TUN/TAP packets/frames.")
    (license license:bsd-3)))

(define-public go-go-uber-org-automaxprocs
  (package
    (name "go-go-uber-org-automaxprocs")
    (version "1.5.3")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/uber-go/automaxprocs")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "03arxcfaj7k6iwfdk0liaynxf9rjfj9m5glsjp7ws01xjkgrdpbc"))))
    (build-system go-build-system)
    (arguments
     '(#:import-path "go.uber.org/automaxprocs"))
    (native-inputs (list go-github-com-stretchr-testify
                         go-github-com-prashantv-gostub))
    (home-page "https://github.com/uber-go/automaxprocs")
    (synopsis "CPU-count detection library for Go")
    (description
     "This package automatically set GOMAXPROCS to match Linux container
CPU quota.")
    (license license:expat)))

;;;
;;; Avoid adding new packages to the end of this file. To reduce the chances
;;; of a merge conflict, place them above by existing packages with similar
;;; functionality or similar names.
;;;
