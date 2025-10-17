# Microsoft.Extensions.Http.Resilience

## Overview

Microsoft.Extensions.Http.Resilience provides production-ready resilience mechanisms for HttpClient built on the proven Polly framework. It offers pre-configured resilience patterns that combine multiple strategies including retry policies, circuit breakers, hedging, rate limiting, and timeouts to ensure reliable HTTP communication in distributed applications.

What it is: A comprehensive resilience library that integrates with HttpClient factory to provide fault tolerance patterns through declarative configuration. Built on Polly, it offers both standard pre-configured pipelines and custom resilience strategy composition for HTTP-based communication reliability.

Core capabilities:

- Standard resilience pipeline: Pre-configured combination of retry, circuit breaker, rate limiter, and timeout strategies
- Standard hedging pipeline: Parallel request execution with circuit breaker pools for endpoint health awareness
- Custom pipeline construction: Flexible composition of resilience strategies for specific requirements
- HttpClient factory integration: Seamless integration with Microsoft.Extensions.Http for dependency injection
- Polly framework foundation: Built on mature, battle-tested resilience patterns and algorithms
- Configurable strategies: Fine-grained control over retry behavior, circuit breaker thresholds, and timeout values

When to use:

- Building production applications that consume external HTTP APIs
- Implementing microservices that require reliable inter-service communication
- Developing applications that need fault tolerance for network operations
- Creating HTTP clients that must handle transient failures gracefully
- Building systems that require protection against cascading failures
- Implementing applications with strict availability and reliability requirements

Key benefits:

- Production reliability: Proven resilience patterns reduce application failures
- Declarative configuration: Simple, readable resilience policy setup through fluent APIs
- Performance optimization: Intelligent request handling through hedging and circuit breaking
- Operational visibility: Built-in telemetry and monitoring for resilience events
- Framework integration: Works seamlessly with ASP.NET Core and HttpClient factory
- Flexible architecture: Supports both standard patterns and custom resilience strategies
