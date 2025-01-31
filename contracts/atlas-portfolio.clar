;; Title: Atlas Portfolio Protocol
;; Summary: Advanced decentralized portfolio management system for Stacks L2
;; Description: A sophisticated DeFi protocol enabling automated portfolio management with 
;; dynamic rebalancing capabilities. Built for the Stacks L2 ecosystem, Atlas Portfolio 
;; Protocol provides institutional-grade portfolio management features including:
;;   - Multi-token portfolio creation and management
;;   - Automated rebalancing with customizable thresholds
;;   - Precise percentage-based asset allocation
;;   - Comprehensive error handling and security measures
;;   - Efficient gas optimization for L2 scalability

;; Constants: Error Codes
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INVALID-PORTFOLIO (err u101))
(define-constant ERR-INSUFFICIENT-BALANCE (err u102))
(define-constant ERR-INVALID-TOKEN (err u103))
(define-constant ERR-REBALANCE-FAILED (err u104))
(define-constant ERR-PORTFOLIO-EXISTS (err u105))
(define-constant ERR-INVALID-PERCENTAGE (err u106))
(define-constant ERR-MAX-TOKENS-EXCEEDED (err u107))
(define-constant ERR-LENGTH-MISMATCH (err u108))
(define-constant ERR-USER-STORAGE-FAILED (err u109))
(define-constant ERR-INVALID-TOKEN-ID (err u110))

;; Protocol Configuration
(define-constant MAX-TOKENS-PER-PORTFOLIO u10)
(define-constant BASIS-POINTS u10000)

;; Protocol State
(define-data-var protocol-owner principal tx-sender)
(define-data-var portfolio-counter uint u0)
(define-data-var protocol-fee uint u25) ;; 0.25% in basis points

;; Data Maps
(define-map Portfolios
    uint  ;; portfolio-id
    {
        owner: principal,
        created-at: uint,
        last-rebalanced: uint,
        total-value: uint,
        active: bool,
        token-count: uint
    }
)