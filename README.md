# Atlas Portfolio Protocol

A sophisticated decentralized portfolio management system built for the Stacks L2 ecosystem, enabling automated portfolio management with dynamic rebalancing capabilities.

## Overview

Atlas Portfolio Protocol is a smart contract system that provides institutional-grade portfolio management features for decentralized finance (DeFi) applications. It allows users to create, manage, and automatically rebalance multi-token portfolios with precise control over asset allocation.

## Features

- **Multi-Token Portfolio Management**

  - Support for up to 10 tokens per portfolio
  - Precise percentage-based asset allocation
  - Dynamic portfolio creation and modification

- **Automated Rebalancing**

  - Time-based rebalancing triggers (24-hour intervals)
  - Customizable allocation thresholds
  - Efficient rebalancing execution

- **Security & Error Handling**

  - Comprehensive authorization checks
  - Robust error handling system
  - Input validation for all operations

- **Gas Optimization**
  - L2-optimized operations
  - Efficient data structures
  - Minimal storage overhead

## Technical Specifications

### Data Structures

#### Portfolios Map

```clarity
{
    owner: principal,
    created-at: uint,
    last-rebalanced: uint,
    total-value: uint,
    active: bool,
    token-count: uint
}
```

#### Portfolio Assets Map

```clarity
{
    target-percentage: uint,
    current-amount: uint,
    token-address: principal
}
```

### Constants

- `MAX_TOKENS_PER_PORTFOLIO`: 10 tokens
- `BASIS_POINTS`: 10000 (100% = 10000 basis points)
- `protocol-fee`: 25 basis points (0.25%)

### Error Codes

| Code | Description          |
| ---- | -------------------- |
| u100 | Not Authorized       |
| u101 | Invalid Portfolio    |
| u102 | Insufficient Balance |
| u103 | Invalid Token        |
| u104 | Rebalance Failed     |
| u105 | Portfolio Exists     |
| u106 | Invalid Percentage   |
| u107 | Max Tokens Exceeded  |
| u108 | Length Mismatch      |
| u109 | User Storage Failed  |
| u110 | Invalid Token ID     |

## Public Functions

### create-portfolio

Creates a new portfolio with specified tokens and allocation percentages.

```clarity
(define-public (create-portfolio (initial-tokens (list 10 principal)) (percentages (list 10 uint))))
```

**Parameters:**

- `initial-tokens`: List of token contract principals
- `percentages`: List of allocation percentages in basis points

**Returns:**

- `(ok uint)`: Portfolio ID on success
- `(err uint)`: Error code on failure

### rebalance-portfolio

Triggers a rebalance operation for a specific portfolio.

```clarity
(define-public (rebalance-portfolio (portfolio-id uint)))
```

**Parameters:**

- `portfolio-id`: ID of the portfolio to rebalance

**Returns:**

- `(ok true)`: Success
- `(err uint)`: Error code on failure

### update-portfolio-allocation

Updates the target allocation for a specific token in a portfolio.

```clarity
(define-public (update-portfolio-allocation (portfolio-id uint) (token-id uint) (new-percentage uint)))
```

**Parameters:**

- `portfolio-id`: Portfolio ID
- `token-id`: Token index in the portfolio
- `new-percentage`: New target percentage in basis points

**Returns:**

- `(ok true)`: Success
- `(err uint)`: Error code on failure

## Read-Only Functions

### get-portfolio

Retrieves portfolio details.

```clarity
(define-read-only (get-portfolio (portfolio-id uint)))
```

### get-portfolio-asset

Retrieves specific asset details from a portfolio.

```clarity
(define-read-only (get-portfolio-asset (portfolio-id uint) (token-id uint)))
```

### get-user-portfolios

Retrieves all portfolio IDs owned by a user.

```clarity
(define-read-only (get-user-portfolios (user principal)))
```

### calculate-rebalance-amounts

Calculates whether a portfolio needs rebalancing.

```clarity
(define-read-only (calculate-rebalance-amounts (portfolio-id uint)))
```

## Usage Examples

### Creating a Portfolio

```clarity
;; Create a portfolio with two tokens
(create-portfolio
    (list 'SP2C2YFP12AJZB4MABJBAJ55XECVS7E4PMMZ89YZR.usda
          'SP3K8BC0PPEVCV7NZ6QSRWPQ2JE9E5B6N3PA0KBR9.wbtc)
    (list u5000 u5000))  ;; 50-50 split
```

### Updating Allocation

```clarity
;; Update token allocation
(update-portfolio-allocation u1 u0 u6000)  ;; Change first token to 60%
```

### Rebalancing

```clarity
;; Trigger portfolio rebalance
(rebalance-portfolio u1)
```

## Security Considerations

1. **Authorization**

   - All portfolio modifications require owner authorization
   - Protocol owner controls are limited to initialization

2. **Input Validation**

   - All percentages must be valid (0-10000 basis points)
   - Token counts must not exceed maximum
   - Portfolio existence verified before operations

3. **Error Handling**
   - Comprehensive error codes for all failure cases
   - Safe unwrapping of optional values
   - Validation before state changes

## Gas Optimization

The contract implements several gas optimization strategies:

1. **Efficient Data Structures**

   - Minimal storage overhead
   - Optimized map structures
   - Limited list sizes

2. **Validation Ordering**

   - Early validation checks
   - Fail-fast approach
   - Minimal state reads

3. **L2 Considerations**
   - Batch operations where possible
   - Efficient state updates
   - Minimal contract calls
