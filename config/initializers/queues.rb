AttachFilesToWorkJob.queue_as(:ingest)
CharacterizeJob.queue_as(:ingest)
ContentDepositEventJob.queue_as(:ingest)
CreateDerivativesJob.queue_as(:derivative)
IngestFileJob.queue_as(:ingest)