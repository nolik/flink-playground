###############################################################################
# Build Job
###############################################################################

FROM maven:3.8-eclipse-temurin-17 AS builder

# Get Click Count job and compile it
COPY ./java/* /opt/flink-job
WORKDIR /opt/flink-job
RUN mvn clean verify


###############################################################################
# Build Operations Playground Image
###############################################################################

FROM apache/flink:1.17.2-scala_2.12-java11

WORKDIR /opt/flink/bin

# Copy Click Count Job
COPY --from=builder /opt/flink-job/target/*.jar /opt/FlinkJob.jar