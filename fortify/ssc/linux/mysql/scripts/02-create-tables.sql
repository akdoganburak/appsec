--  *********************************************************************
--  Update Database Script
--  *********************************************************************
--  Change Log: dbMaster.xml
--  Ran at: 5/12/22, 5:19 AM
--  Against: null@offline:mysql?version=5.0&outputLiquibaseSql=true
--  Liquibase version: 3.8.0
--  *********************************************************************
USE SSC_DB;

CREATE TABLE DATABASECHANGELOG (ID VARCHAR(255) NOT NULL, AUTHOR VARCHAR(255) NOT NULL, FILENAME VARCHAR(255) NOT NULL, DATEEXECUTED datetime NOT NULL, ORDEREXECUTED INT NOT NULL, EXECTYPE VARCHAR(10) NOT NULL, MD5SUM VARCHAR(35) NULL, `DESCRIPTION` VARCHAR(255) NULL, COMMENTS VARCHAR(255) NULL, TAG VARCHAR(255) NULL, LIQUIBASE VARCHAR(20) NULL, CONTEXTS VARCHAR(255) NULL, LABELS VARCHAR(255) NULL, DEPLOYMENT_ID VARCHAR(10) NULL);

--  Changeset dbF360_Init.xml::f360_init_mysql_1::hp
SET collation_connection = @@collation_database;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_init_mysql_1', 'hp', 'dbF360_Init.xml', NOW(), 1, '8:c0200fd5942e9c97af8ac5709e56d3cb', 'sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_2.5.0.xml::f360Mysql_2.5.0::hp
CREATE TABLE activity(
    id                            INT              AUTO_INCREMENT,
    name                          VARCHAR(255),
    description                   VARCHAR(2000),
    activityType                  VARCHAR(20),
    guid                          VARCHAR(255)     NOT NULL,
    objectVersion                 INT,
    publishVersion                INT,
    defaultWorkOwnerPersona_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE activity_persona(
    activity_id    INT    NOT NULL,
    persona_id     INT    NOT NULL,
    PRIMARY KEY (activity_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE activitycomment(
    activityInstance_id    INT              NOT NULL,
    commentTime            DATETIME         NOT NULL,
    userName               VARCHAR(255),
    commentText            VARCHAR(4000),
    commentType            VARCHAR(20),
    PRIMARY KEY (activityInstance_id, commentTime)
)ENGINE=INNODB;

CREATE TABLE activityinstance(
    id                        INT              AUTO_INCREMENT,
    projectVersion_id         INT              NOT NULL,
    activity_id               INT,
    name                      VARCHAR(255),
    description               VARCHAR(2000),
    activityType              VARCHAR(20),
    signOffState              VARCHAR(20),
    signOffDate               DATETIME,
    objectVersion             INT,
    seqNumber                 INT,
    requirementInstance_id    INT,
    savedEvidence_id          INT,
    workOwner                 VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE activitysignoff(
    activityInstance_id    INT             NOT NULL,
    persona_id             INT             NOT NULL,
    signOffState           VARCHAR(20)     NOT NULL,
    signOffDate            DATETIME,
    signOffUser            VARCHAR(255),
    PRIMARY KEY (activityInstance_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE agentcredential(
    id                   INT             AUTO_INCREMENT,
    token                VARCHAR(255),
    action               VARCHAR(255),
    remainingAttempts    INT,
    credential           BLOB,
    userName             VARCHAR(255),
    creationIp           VARCHAR(255),
    creationDate         DATETIME,
    terminalDate         DATETIME,
    sessionId            VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE alert(
    id                     INT              AUTO_INCREMENT,
    name                   VARCHAR(255),
    description            VARCHAR(2000),
    monitoredEntityType    VARCHAR(20),
    monitoredInstanceId    INT,
    startDate              DATETIME,
    endDate                DATETIME,
    additionalParams       VARCHAR(255),
    createdBy              VARCHAR(255),
    creationDate           DATETIME,
    objectVersion          INT,
    reminderPeriod         INT,
    enabled                CHAR(1)          DEFAULT 'Y' NOT NULL,
    alertAllChildren       CHAR(1)          DEFAULT 'N',
    alertStakeholders      CHAR(1)          DEFAULT 'N',
    monitorAllApps         CHAR(1)          DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE alert_role(
    alert_id    INT    NOT NULL,
    pt_id       INT    NOT NULL,
    PRIMARY KEY (alert_id, pt_id)
)ENGINE=INNODB;

CREATE TABLE alerthistory(
    id                     INT             AUTO_INCREMENT,
    alert_id               INT             NOT NULL,
    userName               VARCHAR(255),
    triggeredDate          DATETIME,
    active                 CHAR(1),
    monitoredEntityType    VARCHAR(20),
    monitoredInstanceId    INT,
    monitoredEntityName    VARCHAR(255),
    alertStartDate         DATETIME,
    projectVersion_id      INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE alerttrigger(
    alert_id           INT            NOT NULL,
    monitoredColumn    VARCHAR(80)    NOT NULL,
    triggeredValue     VARCHAR(80)    NOT NULL,
    PRIMARY KEY (alert_id, monitoredColumn, triggeredValue)
)ENGINE=INNODB;

CREATE TABLE analysisblob(
    projectVersion_id    INT            NOT NULL,
    issueInstanceId      VARCHAR(80)    NOT NULL,
    engineType           VARCHAR(20)    NOT NULL,
    analysisTrace        MEDIUMBLOB,
    PRIMARY KEY (projectVersion_id, issueInstanceId, engineType)
)ENGINE=INNODB;

CREATE TABLE applicationassignmentrule(
    id                       INT             AUTO_INCREMENT,
    context                  VARCHAR(512),
    objectVersion            INT,
    seqNumber                INT,
    runtimeApplication_id    INT             NOT NULL,
    name                     VARCHAR(255),
    description              TEXT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE applicationassignmentrule_host(
    applicationAssignmentRule_id    INT    NOT NULL,
    host_id                         INT    NOT NULL,
    PRIMARY KEY (applicationAssignmentRule_id, host_id)
)ENGINE=INNODB;

CREATE TABLE applicationentity(
    id               INT            AUTO_INCREMENT,
    objectVersion    INT,
    appEntityType    VARCHAR(20),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE artifact(
    id                   INT              AUTO_INCREMENT,
    projectVersion_id    INT              NOT NULL,
    documentInfo_id      INT              NOT NULL,
    artifactType         VARCHAR(20),
    status               VARCHAR(20),
    messages             VARCHAR(2000),
    allowDelete          CHAR(1)          DEFAULT 'Y',
    srcArtifact_id       INT,
    purged               CHAR(1)          DEFAULT 'N',
    auditUpdated         CHAR(1)          DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE attr(
    id               INT              AUTO_INCREMENT,
    guid             VARCHAR(255)     NOT NULL,
    attrName         VARCHAR(80)      NOT NULL,
    attrType         VARCHAR(20)      NOT NULL,
    description      VARCHAR(2000),
    extensible       CHAR(1),
    masterAttr       CHAR(1)          DEFAULT 'N',
    defaultValue     INT,
    objectVersion    INT,
    hidden           CHAR(1)          DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE attrlookup(
    attr_id        INT             NOT NULL,
    lookupIndex    INT             NOT NULL,
    lookupValue    VARCHAR(255),
    attrGuid       VARCHAR(255),
    hidden         CHAR(1)         DEFAULT 'N',
    seqNumber      INT,
    PRIMARY KEY (attr_id, lookupIndex)
)ENGINE=INNODB;

CREATE TABLE auditcomment(
    issue_id       INT              NOT NULL,
    seqNumber      INT              NOT NULL,
    auditTime      BIGINT,
    commentText    VARCHAR(2000),
    userName       VARCHAR(255),
    PRIMARY KEY (issue_id, seqNumber)
)ENGINE=INNODB;

CREATE TABLE audithistory(
    issue_id             INT             NOT NULL,
    seqNumber            INT             NOT NULL,
    attrGuid             VARCHAR(255),
    auditTime            BIGINT,
    oldValue             INT,
    newValue             INT,
    userName             VARCHAR(255),
    conflict             CHAR(1)         DEFAULT 'N',
    projectVersion_id    INT             NOT NULL,
    PRIMARY KEY (issue_id, seqNumber)
)ENGINE=INNODB;

CREATE TABLE auditvalue(
    issue_id             INT            NOT NULL,
    attrGuid             VARCHAR(80)    NOT NULL,
    attrValue            INT,
    projectVersion_id    INT            NOT NULL,
    PRIMARY KEY (issue_id, attrGuid)
)ENGINE=INNODB;

CREATE TABLE consoleeventhandler(
    id                              INT             AUTO_INCREMENT,
    name                            VARCHAR(255)    NOT NULL,
    objectVersion                   INT             NOT NULL,
    description                     TEXT,
    eventHandlerType                VARCHAR(20),
    matchConditionsXml              TEXT,
    additionalMatchConditionsXml    TEXT,
    enabled                         CHAR(1),
    runtimeConfiguration_id         INT             NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE controller(
    id                        INT        AUTO_INCREMENT,
    port                      INT,
    allowNewClients           CHAR(1)    DEFAULT 'N',
    strictCertCheck           CHAR(1)    DEFAULT 'N',
    controllerKeyKeeper_id    INT        NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE controllerkeykeeper(
    id           INT            AUTO_INCREMENT,
    keystore     LONGBLOB,
    integrity    VARCHAR(20),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE datablob(
    id      INT         AUTO_INCREMENT,
    data    LONGBLOB,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE documentactivity(
    id                INT    NOT NULL,
    documentDef_id    INT    NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE documentai(
    id                     INT    NOT NULL,
    documentDef_id         INT    NOT NULL,
    documentArtifact_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE documentartifact(
    id                   INT              AUTO_INCREMENT,
    name                 VARCHAR(255),
    description          VARCHAR(2000),
    projectVersion_id    INT              NOT NULL,
    documentInfo_id      INT              NOT NULL,
    status               VARCHAR(20),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE documentartifact_def(
    documentArtifact_id    INT    NOT NULL,
    documentDef_id         INT    NOT NULL,
    PRIMARY KEY (documentArtifact_id, documentDef_id)
)ENGINE=INNODB;

CREATE TABLE documentdef(
    id                 INT              AUTO_INCREMENT,
    guid               VARCHAR(255)     NOT NULL,
    name               VARCHAR(255),
    description        VARCHAR(2000),
    templateInfo_id    INT,
    objectVersion      INT,
    publishVersion     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE documentdefinstance(
    activityInstance_id    INT              NOT NULL,
    name                   VARCHAR(255),
    description            VARCHAR(2000),
    documentDef_id         INT              NOT NULL,
    templateInfo_id        INT,
    PRIMARY KEY (activityInstance_id)
)ENGINE=INNODB;

CREATE TABLE documentinfo(
    id                  INT              AUTO_INCREMENT,
    documentType        INT,
    originalFileName    VARCHAR(1999),
    fileName            VARCHAR(255),
    fileURL             VARCHAR(1999),
    versionNumber       INT,
    uploadDate          DATETIME,
    uploadIP            VARCHAR(255),
    fileSize            BIGINT,
    userName            VARCHAR(255),
    fileBlob_id         INT,
    objectVersion       INT,
    externalFlag        CHAR(1)          DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE dynamicassessment(
    id                   INT             AUTO_INCREMENT,
    projectVersion_id    INT             NOT NULL,
    artifactId           INT,
    siteUrl              VARCHAR(255),
    siteScanStatus       VARCHAR(255),
    creationDate         DATETIME,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE entitytype(
    id            INT             NOT NULL,
    entityName    VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE eventlogentry(
    id                   INT              AUTO_INCREMENT,
    eventType            VARCHAR(255),
    userName             VARCHAR(255),
    eventDate            DATETIME,
    detailedNote         VARCHAR(4000),
    entity_id            INT,
    projectVersion_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE f360global(
    id               INT             AUTO_INCREMENT,
    schemaVersion    VARCHAR(255)    NOT NULL,
    publicKey        BLOB,
    privateKey       BLOB,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE federation(
    id                         INT              AUTO_INCREMENT,
    federationName             VARCHAR(255),
    description                VARCHAR(2000),
    defaultFederation          CHAR(1),
    objectVersion              INT,
    runtimeConfiguration_id    INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE filterset(
    id                   INT              AUTO_INCREMENT,
    projectVersion_id    INT,
    title                VARCHAR(80),
    description          VARCHAR(2000),
    guid                 VARCHAR(255),
    disableEdit          CHAR(1)          DEFAULT 'N',
    enabled              CHAR(1)          DEFAULT 'Y',
    filterSetType        VARCHAR(20),
    defaultFolder_id     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE finding(
    projectVersion_id    INT              NOT NULL,
    guid                 VARCHAR(255)     NOT NULL,
    name                 VARCHAR(255),
    description          VARCHAR(2000),
    findingType          VARCHAR(80),
    PRIMARY KEY (projectVersion_id, guid)
)ENGINE=INNODB;

CREATE TABLE folder(
    id                   INT              AUTO_INCREMENT,
    projectVersion_id    INT              NOT NULL,
    name                 VARCHAR(80),
    description          VARCHAR(2000),
    guid                 VARCHAR(255),
    color                VARCHAR(20),
    editable             CHAR(1),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE foldercountcache(
    projectVersion_id    INT        NOT NULL,
    filterSet_id         INT        NOT NULL,
    folder_id            INT        NOT NULL,
    hidden               CHAR(1)    NOT NULL,
    removed              CHAR(1)    NOT NULL,
    suppressed           CHAR(1)    NOT NULL,
    issueCount           INT,
    PRIMARY KEY (projectVersion_id, filterSet_id, folder_id, hidden, removed, suppressed)
)ENGINE=INNODB;

CREATE TABLE fortifyuser(
    id                       INT             NOT NULL,
    userName                 VARCHAR(255)    NOT NULL,
    password                 VARCHAR(255),
    requirePasswordChange    CHAR(1)         NOT NULL,
    lastPasswordChange       DATETIME,
    passwordNeverExpire      CHAR(1)         NOT NULL,
    failedLoginAttempts      INT             NOT NULL,
    dateFrozen               DATETIME,
    firstName                VARCHAR(255),
    lastName                 VARCHAR(255),
    email                    VARCHAR(255),
    remoteKey                VARCHAR(255),
    suspended                CHAR(1)         NOT NULL,
    secPass                  VARCHAR(255),
    salt                     VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE fpr_scan(
    scan_id        INT    NOT NULL,
    artifact_id    INT    NOT NULL,
    PRIMARY KEY (scan_id, artifact_id)
)ENGINE=INNODB;

CREATE TABLE host(
    id               INT              AUTO_INCREMENT,
    hostName         VARCHAR(255),
    address          VARCHAR(255),
    hostType         VARCHAR(20),
    statusCode       VARCHAR(20),
    statusMessage    VARCHAR(2000),
    os               VARCHAR(50),
    osVersion        VARCHAR(50),
    vm               VARCHAR(50),
    vmVersion        VARCHAR(50),
    lastComm         DATETIME,
    enabled          CHAR(1)          DEFAULT 'Y',
    hasConnected     CHAR(1)          DEFAULT 'N',
    logHasWarning    CHAR(1)          DEFAULT 'N',
    logHasError      CHAR(1)          DEFAULT 'N',
    connAttempts     INT,
    federation_id    INT              NOT NULL,
    controller_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE hostlogmessage(
    id              INT              AUTO_INCREMENT,
    creationDate    DATETIME,
    logLevel        VARCHAR(20),
    msg             VARCHAR(4000),
    host_id         INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE idgenerator(
    id             INT             AUTO_INCREMENT,
    sessionGuid    VARCHAR(255)    NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE iidmapping(
    migration_id      INT             NOT NULL,
    fromInstanceId    VARCHAR(255)    NOT NULL,
    toInstanceId      VARCHAR(255)    NOT NULL,
    seqNumber         INT,
    PRIMARY KEY (migration_id, fromInstanceId, toInstanceId)
)ENGINE=INNODB;

CREATE TABLE iidmigration(
    id                   INT         AUTO_INCREMENT,
    artifact_id          INT,
    processingDate       DATETIME,
    projectVersion_id    INT         NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE issue(
    id                     INT              AUTO_INCREMENT,
    remediationConstant    FLOAT(8, 2),
    projectVersion_id      INT              NOT NULL,
    issueInstanceId        VARCHAR(80)      NOT NULL,
    fileName               VARCHAR(500),
    shortFileName          VARCHAR(255),
    severity               FLOAT(8, 2),
    ruleGuid               VARCHAR(120),
    confidence             FLOAT(8, 2),
    kingdom                VARCHAR(80),
    issueType              VARCHAR(120),
    issueSubtype           VARCHAR(180),
    analyzer               VARCHAR(80),
    lineNumber             INT,
    taintFlag              VARCHAR(255),
    packageName            VARCHAR(255),
    functionName           VARCHAR(1024),
    className              VARCHAR(255),
    issueAbstract          TEXT,
    friority               VARCHAR(20),
    engineType             VARCHAR(20),
    scanStatus             VARCHAR(20),
    audienceSet            VARCHAR(100),
    lastScan_id            INT,
    replaceStore           BLOB,
    snippetId              VARCHAR(512),
    url                    VARCHAR(1000),
    category               VARCHAR(300),
    source                 VARCHAR(255),
    sourceContext          VARCHAR(1000),
    sourceFile             VARCHAR(255),
    sink                   VARCHAR(1000),
    sinkContext            VARCHAR(1000),
    userName               VARCHAR(255),
    owasp2004              VARCHAR(120),
    owasp2007              VARCHAR(120),
    cwe                    VARCHAR(120),
    objectVersion          INT,
    revision               INT              DEFAULT 0,
    audited                CHAR(1)          DEFAULT 'N',
    auditedTime            DATETIME,
    suppressed             CHAR(1)          DEFAULT 'N',
    issueStatus            VARCHAR(20)      DEFAULT 'Unreviewed',
    issueState             VARCHAR(20)      DEFAULT 'Open Issue',
    findingGuid            VARCHAR(500),
    dynamicConfidence      INT              DEFAULT 0,
    hidden                 CHAR(1)          DEFAULT 'N',
    likelihood             FLOAT(8, 2),
    impact                 FLOAT(8, 2),
    accuracy               FLOAT(8, 2),
    sans25                 VARCHAR(120),
    wasc                   VARCHAR(120),
    stig                   VARCHAR(120),
    pci11                  VARCHAR(120),
    pci12                  VARCHAR(120),
    rtaCovered             VARCHAR(120),
    probability            FLOAT(8, 2),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE issuecache(
    filterSet_id         INT             NOT NULL,
    issue_id             INT             NOT NULL,
    projectVersion_id    INT,
    folder_id            INT,
    hidden               CHAR(1)         DEFAULT 'N',
    issueInstanceId      VARCHAR(255),
    PRIMARY KEY (filterSet_id, issue_id)
)ENGINE=INNODB;

CREATE TABLE ldapentity(
    id        INT             NOT NULL,
    ldapDn    VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE measurement(
    id                 INT              AUTO_INCREMENT,
    name               VARCHAR(255),
    description        VARCHAR(2000),
    equation           VARCHAR(1000),
    guid               VARCHAR(255)     NOT NULL,
    valueFormat        VARCHAR(255),
    measurementType    VARCHAR(20),
    objectVersion      INT,
    publishVersion     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE measurement_variable(
    measurement_id    INT    NOT NULL,
    variable_id       INT    NOT NULL,
    PRIMARY KEY (measurement_id, variable_id)
)ENGINE=INNODB;

CREATE TABLE measurementhistory(
    id                  INT            AUTO_INCREMENT,
    measurement_id      INT            NOT NULL,
    creationTime        DATETIME,
    measurementValue    FLOAT(8, 2),
    snapshot_id         INT            NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE measurementinstance(
    activityInstance_id       INT              NOT NULL,
    measurement_id            INT              NOT NULL,
    measurementName           VARCHAR(255),
    measurementDescription    VARCHAR(2000),
    equation                  VARCHAR(1000),
    measurementValue          FLOAT(8, 2),
    valueFormat               VARCHAR(255),
    PRIMARY KEY (activityInstance_id)
)ENGINE=INNODB;

CREATE TABLE metadatarule(
    id             INT              AUTO_INCREMENT,
    name           VARCHAR(255),
    description    VARCHAR(2000),
    ruleType       VARCHAR(20),
    conditions     TEXT,
    seqNumber      INT,
    guid           VARCHAR(255)     NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE metadef(
    id                 INT             AUTO_INCREMENT,
    parent_id          INT,
    metaType           VARCHAR(255),
    seqNumber          INT,
    required           CHAR(1)         DEFAULT 'N',
    hidden             CHAR(1)         DEFAULT 'N',
    booleanDefault     CHAR(1)         DEFAULT 'N',
    guid               VARCHAR(255)    NOT NULL,
    parentOption_id    INT,
    category           VARCHAR(20),
    appEntityType      VARCHAR(80),
    objectVersion      INT,
    publishVersion     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE metadef_t(
    metaDef_id     INT              NOT NULL,
    lang           VARCHAR(10)      NOT NULL,
    name           VARCHAR(255),
    description    VARCHAR(2000),
    help           VARCHAR(2000),
    PRIMARY KEY (metaDef_id, lang)
)ENGINE=INNODB;

CREATE TABLE metaoption(
    id                  INT             AUTO_INCREMENT,
    optionIndex         INT,
    metaDef_id          INT,
    defaultSelection    CHAR(1)         DEFAULT 'N',
    hidden              CHAR(1)         DEFAULT 'N',
    guid                VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE metaoption_t(
    metaOption_id    INT              NOT NULL,
    lang             VARCHAR(255)     NOT NULL,
    name             VARCHAR(255),
    description      VARCHAR(2000),
    help             VARCHAR(2000),
    PRIMARY KEY (metaOption_id, lang)
)ENGINE=INNODB;

CREATE TABLE metavalue(
    id                   INT              AUTO_INCREMENT,
    metaDef_id           INT              NOT NULL,
    textValue            VARCHAR(2000),
    booleanValue         CHAR(1),
    objectVersion        INT,
    projectVersion_id    INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE metavalueselection(
    metaValue_id     INT    NOT NULL,
    metaOption_id    INT    NOT NULL,
    PRIMARY KEY (metaValue_id, metaOption_id)
)ENGINE=INNODB;

CREATE TABLE payloadartifact(
    id                         INT              AUTO_INCREMENT,
    projectVersion_id          INT              NOT NULL,
    analysisDoc_id             INT,
    dependencyDoc_id           INT,
    sourceDoc_id               INT,
    status                     VARCHAR(20),
    messages                   VARCHAR(2000),
    additionalInput            MEDIUMBLOB,
    defaultAnalyzeCount        INT,
    jobId                      INT,
    totalAnalysisFilesCount    INT,
    totalSourceFilesCount      INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE payloadentry(
    id             INT              AUTO_INCREMENT,
    artifact_id    INT              NOT NULL,
    filePath       VARCHAR(2000),
    fileName       VARCHAR(255),
    fileType       VARCHAR(20),
    fileSize       INT,
    selected       CHAR(1)          DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE payloadmessage(
    id              INT            AUTO_INCREMENT,
    artifact_id     INT            NOT NULL,
    messageType     VARCHAR(20),
    messageCode     INT,
    extraMessage    TEXT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE permission(
    id               INT             AUTO_INCREMENT,
    name             VARCHAR(255)    NOT NULL,
    type             INT             NOT NULL,
    entityType_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE permissioninstance(
    id                  INT    AUTO_INCREMENT,
    entityInstanceId    INT,
    permission_id       INT    NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE permissiontemplate(
    id           INT             AUTO_INCREMENT,
    name         VARCHAR(255)    NOT NULL,
    builtin      CHAR(1)         NOT NULL,
    isDefault    CHAR(1)         NOT NULL,
    userOnly     CHAR(1)         NOT NULL,
    sortOrder    INT             NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE persona(
    id                INT             AUTO_INCREMENT,
    guid              VARCHAR(255),
    name              VARCHAR(255),
    description       TEXT,
    objectVersion     INT,
    publishVersion    INT,
    superuser         CHAR(1)         DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE personaassignment(
    projectVersion_id    INT             NOT NULL,
    persona_id           INT             NOT NULL,
    userName             VARCHAR(255),
    PRIMARY KEY (projectVersion_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE pod(
    id                 INT             AUTO_INCREMENT,
    podType            VARCHAR(255),
    podName            VARCHAR(255),
    multipleEnabled    CHAR(1)         DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE pref_pod(
    id           INT              AUTO_INCREMENT,
    pref_id      INT,
    pod_id       INT              NOT NULL,
    minimized    CHAR(1)          DEFAULT 'N',
    maximized    CHAR(1)          DEFAULT 'N',
    selection    VARCHAR(4000),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE pref_projectversion(
    pref_id              INT    NOT NULL,
    projectVersion_id    INT    NOT NULL,
    PRIMARY KEY (pref_id, projectVersion_id)
)ENGINE=INNODB;

CREATE TABLE project(
    id              INT              AUTO_INCREMENT,
    name            VARCHAR(255),
    description     VARCHAR(2000),
    creationDate    DATETIME,
    createdBy       VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE projectstateactivity(
    id                INT            NOT NULL,
    compareType       VARCHAR(20),
    compareValue      FLOAT(8, 2),
    measurement_id    INT            NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE projectstateai(
    id                INT            NOT NULL,
    compareType       VARCHAR(20),
    compareValue      FLOAT(8, 2),
    measurement_id    INT            NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE projecttemplate(
    id                 INT              AUTO_INCREMENT,
    documentInfo_id    INT              NOT NULL,
    name               VARCHAR(255),
    description        VARCHAR(2000),
    guid               VARCHAR(255)     NOT NULL,
    objectVersion      INT,
    publishVersion     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE projecttemplate_attr(
    projectTemplate_id    INT             NOT NULL,
    attrGuid              VARCHAR(255)    NOT NULL,
    seqNumber             INT,
    PRIMARY KEY (projectTemplate_id, attrGuid)
)ENGINE=INNODB;

CREATE TABLE projectversion(
    id                      INT              NOT NULL,
    name                    VARCHAR(255)     NOT NULL,
    description             VARCHAR(1999),
    versionTag              VARCHAR(255),
    active                  CHAR(1)          DEFAULT 'N',
    modifiedAfterCommit     CHAR(1),
    creationDate            DATETIME,
    createdBy               VARCHAR(255),
    objectVersion           INT,
    projectTemplate_id      INT,
    project_id              INT,
    versionCommitted        CHAR(1)          DEFAULT 'N',
    versionMode             VARCHAR(20),
    locked                  CHAR(1)          DEFAULT 'N',
    auditAllowed            CHAR(1)          DEFAULT 'Y',
    staleProjectTemplate    CHAR(1)          DEFAULT 'N',
    loadProperties          VARCHAR(1999),
    currentFprBlob_id       INT,
    snapshotOutOfDate       CHAR(1)          DEFAULT 'N',
    assessmentState         VARCHAR(20),
    owner                   VARCHAR(255),
    serverVersion           FLOAT(8, 0),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE projectversion_alert(
    alert_id             INT    NOT NULL,
    projectVersion_id    INT    NOT NULL,
    PRIMARY KEY (alert_id, projectVersion_id)
)ENGINE=INNODB;

CREATE TABLE projectversion_rule(
    projectVersion_id    INT             NOT NULL,
    rule_id              INT             NOT NULL,
    ruleGuid             VARCHAR(255),
    engineType           VARCHAR(20),
    PRIMARY KEY (projectVersion_id, rule_id)
)ENGINE=INNODB;

CREATE TABLE projectversiondependency(
    parentProjectVersion_id    INT    NOT NULL,
    childProjectVersion_id     INT    NOT NULL,
    PRIMARY KEY (parentProjectVersion_id, childProjectVersion_id)
)ENGINE=INNODB;

CREATE TABLE pt_permission(
    pt_id            INT    NOT NULL,
    permission_id    INT    NOT NULL,
    PRIMARY KEY (pt_id, permission_id)
)ENGINE=INNODB;

CREATE TABLE publishaction(
    publishedReport_id    INT             NOT NULL,
    procurerTenantId      VARCHAR(255)    NOT NULL,
    procurer_id           INT             NOT NULL,
    publishedBy           VARCHAR(255),
    publishDate           DATETIME,
    PRIMARY KEY (publishedReport_id, procurerTenantId)
)ENGINE=INNODB;

CREATE TABLE publishedreport(
    id                    INT              AUTO_INCREMENT,
    assessmentName        VARCHAR(255),
    vendorTenantId        VARCHAR(255)     NOT NULL,
    savedReport_id        VARCHAR(255),
    name                  VARCHAR(255),
    note                  VARCHAR(1999),
    format                VARCHAR(20),
    generatedBy           VARCHAR(255),
    generationDate        DATETIME,
    reportOutputDoc_id    INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE report_projectversion(
    savedReport_id       INT    NOT NULL,
    projectVersion_id    INT    NOT NULL,
    PRIMARY KEY (savedReport_id, projectVersion_id)
)ENGINE=INNODB;

CREATE TABLE reportdefinition(
    id                 INT              AUTO_INCREMENT,
    name               VARCHAR(255)     NOT NULL,
    description        VARCHAR(2000),
    reportType         VARCHAR(20),
    renderingEngine    VARCHAR(20),
    crossApp           CHAR(1)          DEFAULT 'N',
    guid               VARCHAR(255),
    templateDoc_id     INT,
    objectVersion      INT,
    publishVersion     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE reportparameter(
    id                     INT              AUTO_INCREMENT,
    paramName              VARCHAR(255)     NOT NULL,
    description            VARCHAR(2000),
    dataType               VARCHAR(20)      NOT NULL,
    entityType             VARCHAR(40),
    identifier             VARCHAR(80),
    reportDefinition_id    INT              NOT NULL,
    paramOrder             INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE requirement(
    id                            INT              AUTO_INCREMENT,
    requirementTemplate_id        INT              NOT NULL,
    name                          VARCHAR(255),
    description                   VARCHAR(2000),
    tag                           VARCHAR(255),
    seqNumber                     INT,
    defaultWorkOwnerPersona_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE requirement_activity(
    requirement_id    INT    NOT NULL,
    activity_id       INT    NOT NULL,
    seqNumber         INT,
    PRIMARY KEY (requirement_id, activity_id)
)ENGINE=INNODB;

CREATE TABLE requirement_persona(
    requirement_id    INT    NOT NULL,
    persona_id        INT    NOT NULL,
    PRIMARY KEY (requirement_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE requirementcomment(
    requirementInstance_id    INT              NOT NULL,
    commentTime               DATETIME         NOT NULL,
    commentText               VARCHAR(4000),
    userName                  VARCHAR(255),
    commentType               VARCHAR(20),
    PRIMARY KEY (requirementInstance_id, commentTime)
)ENGINE=INNODB;

CREATE TABLE requirementinstance(
    id                   INT              AUTO_INCREMENT,
    projectVersion_id    INT              NOT NULL,
    requirement_id       INT,
    name                 VARCHAR(255),
    description          VARCHAR(2000),
    tag                  VARCHAR(255),
    signOffState         VARCHAR(20),
    signOffDate          DATETIME,
    objectVersion        INT,
    seqNumber            INT,
    workOwner            VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE requirementsignoff(
    requirementInstance_id    INT             NOT NULL,
    persona_id                INT             NOT NULL,
    signOffState              VARCHAR(20)     NOT NULL,
    signOffDate               DATETIME,
    signOffUser               VARCHAR(255),
    PRIMARY KEY (requirementInstance_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE requirementtemplate(
    id                            INT              AUTO_INCREMENT,
    name                          VARCHAR(255),
    description                   VARCHAR(2000),
    guid                          VARCHAR(255)     NOT NULL,
    projectTemplate_id            INT,
    hidden                        CHAR(1)          DEFAULT 'N',
    defaultTemplate               CHAR(1)          DEFAULT 'N',
    templateMode                  VARCHAR(20),
    objectVersion                 INT,
    publishVersion                INT,
    defaultWorkOwnerPersona_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE requirementtemplate_persona(
    requirementTemplate_id    INT    NOT NULL,
    persona_id                INT    NOT NULL,
    PRIMARY KEY (requirementTemplate_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE requirementtemplatecomment(
    projectVersion_id    INT              NOT NULL,
    commentTime          DATETIME         NOT NULL,
    commentText          VARCHAR(4000),
    userName             VARCHAR(255),
    commentType          VARCHAR(20),
    PRIMARY KEY (projectVersion_id, commentTime)
)ENGINE=INNODB;

CREATE TABLE requirementtemplateinstance(
    projectVersion_id         INT              NOT NULL,
    requirementTemplate_id    INT              NOT NULL,
    override                  CHAR(1)          DEFAULT 'N',
    metadataRule_id           INT,
    signOffState              VARCHAR(20),
    signOffDate               DATETIME,
    name                      VARCHAR(255),
    description               VARCHAR(2000),
    guid                      VARCHAR(255),
    objectVersion             INT,
    savedEvidence_id          INT,
    workOwner                 VARCHAR(255),
    serverVersion             FLOAT(8, 0),
    PRIMARY KEY (projectVersion_id)
)ENGINE=INNODB;

CREATE TABLE requirementtemplatesignoff(
    projectVersion_id    INT             NOT NULL,
    persona_id           INT             NOT NULL,
    signOffState         VARCHAR(20)     NOT NULL,
    signOffDate          DATETIME,
    signOffUser          VARCHAR(255),
    PRIMARY KEY (projectVersion_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE rtassignment(
    metadataRule_id           INT    NOT NULL,
    requirementTemplate_id    INT    NOT NULL,
    objectVersion             INT,
    publishVersion            INT,
    PRIMARY KEY (metadataRule_id, requirementTemplate_id)
)ENGINE=INNODB;

CREATE TABLE rule_t(
    id                   INT            NOT NULL,
    lang                 VARCHAR(10)    NOT NULL,
    rawDetail            TEXT,
    rawRecommendation    TEXT,
    rawRuleAbstract      TEXT,
    detail               TEXT,
    recommendation       TEXT,
    ruleAbstract         TEXT,
    PRIMARY KEY (id, lang)
)ENGINE=INNODB;

CREATE TABLE ruledescription(
    id             INT             AUTO_INCREMENT,
    guid           VARCHAR(255),
    rulepack_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE rulepack(
    id                 INT              AUTO_INCREMENT,
    sku                VARCHAR(255),
    rulepackGuid       VARCHAR(255)     NOT NULL,
    name               VARCHAR(255)     NOT NULL,
    description        VARCHAR(1999),
    versionNumber      VARCHAR(255),
    progLanguage       VARCHAR(255),
    rulepackType       VARCHAR(20),
    objectVersion      INT,
    documentInfo_id    INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimealert(
    id                         INT             NOT NULL,
    runtimeEvent_id            INT             NOT NULL,
    eventHandlerName           VARCHAR(255),
    eventHandlerDescription    TEXT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimeapplication(
    id                    INT              NOT NULL,
    name                  VARCHAR(255)     NOT NULL,
    description           VARCHAR(2000),
    creationDate          DATETIME,
    createdBy             VARCHAR(255),
    objectVersion         INT,
    defaultApplication    CHAR(1),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimeconfig_rulepack(
    runtimeConfiguration_id    INT    NOT NULL,
    rulepack_id                INT    NOT NULL,
    seqNumber                  INT,
    PRIMARY KEY (runtimeConfiguration_id, rulepack_id)
)ENGINE=INNODB;

CREATE TABLE runtimeconfiguration(
    id                    INT              AUTO_INCREMENT,
    configGuid            VARCHAR(255),
    configName            VARCHAR(255),
    description           VARCHAR(2000),
    lastModification      DATETIME,
    objectVersion         INT,
    enabled               CHAR(1)          DEFAULT 'Y',
    protectModeEnabled    CHAR(1)          DEFAULT 'N',
    templateInfo_id       INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimeevent(
    id                        INT              NOT NULL,
    category                  VARCHAR(512),
    ruleId                    VARCHAR(255),
    monitorId                 VARCHAR(255),
    exceptionStackChecksum    VARCHAR(255),
    eventStackChecksum        VARCHAR(255),
    eventType                 VARCHAR(120),
    creationDate              DATETIME,
    descriptionPath           VARCHAR(255),
    severity                  FLOAT(8, 0),
    accuracy                  FLOAT(8, 0),
    impact                    FLOAT(8, 0),
    impactBias                VARCHAR(120),
    audience                  VARCHAR(120),
    primaryAudience           VARCHAR(20),
    coveredRta                CHAR(1),
    coveredSca                CHAR(1),
    requestHeader             TEXT,
    requestIp                 VARCHAR(255),
    sessionId                 VARCHAR(255),
    requestUri                VARCHAR(2084),
    requestParameter          TEXT,
    authedUser                VARCHAR(255),
    cookie                    TEXT,
    referer                   VARCHAR(2084),
    userAgent                 VARCHAR(255),
    triggeredBy               TEXT,
    action                    VARCHAR(255),
    dispatch                  VARCHAR(255),
    kingdom                   VARCHAR(100),
    hourDate                  INT,
    isAttack                  CHAR(1)          DEFAULT 'N',
    isVulnerability           CHAR(1)          DEFAULT 'N',
    isAudit                   CHAR(1)          DEFAULT 'N',
    requestMethod             VARCHAR(20),
    likelihood                FLOAT(8, 0),
    priority                  VARCHAR(20),
    processed                 CHAR(1)          DEFAULT 'N',
    alerted                   CHAR(1)          DEFAULT 'N',
    probability               FLOAT(8, 0),
    requestScheme             VARCHAR(20),
    host_id                   INT              NOT NULL,
    runtimeApplication_id     INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimeeventarchive(
    id                        INT             AUTO_INCREMENT,
    startDate                 DATETIME,
    endDate                   DATETIME,
    runtimeApplication_id     INT,
    runtimeApplicationName    VARCHAR(255),
    notes                     TEXT,
    restored                  CHAR(1)         DEFAULT 'N',
    documentInfo_id           INT             NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimeeventattr(
    runtimeEvent_id    INT             NOT NULL,
    attrName           VARCHAR(255)    NOT NULL,
    attrValue          MEDIUMTEXT,
    trusted            CHAR(1)         DEFAULT 'N',
    internal           CHAR(1)         DEFAULT 'N',
    PRIMARY KEY (runtimeEvent_id, attrName)
)ENGINE=INNODB;

CREATE TABLE runtimenamedattr(
    id                        INT             AUTO_INCREMENT,
    attrName                  VARCHAR(255),
    attrValue                 VARCHAR(255),
    runtimeNamedAttrSet_id    INT             NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimenamedattrset(
    id                INT             AUTO_INCREMENT,
    rulepack_id       INT,
    attributeSetId    VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimesetting(
    id                         INT             AUTO_INCREMENT,
    objectVersion              INT,
    settingKey                 VARCHAR(255),
    name                       VARCHAR(255),
    content                    VARCHAR(255),
    description                TEXT,
    settingType                VARCHAR(20),
    systemDefined              CHAR(1),
    runtimeConfiguration_id    INT             NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE savedevidence(
    id                   INT            AUTO_INCREMENT,
    evidenceType         VARCHAR(20),
    creationDate         DATETIME,
    projectVersion_id    INT,
    evidenceBlob_id      INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE savedreport(
    id                     INT              AUTO_INCREMENT,
    name                   VARCHAR(255)     NOT NULL,
    note                   VARCHAR(1999),
    generationDate         DATETIME         NOT NULL,
    userName               VARCHAR(255),
    format                 VARCHAR(20),
    status                 VARCHAR(20),
    published              CHAR(1)          DEFAULT 'N',
    reportDefinition_id    INT              NOT NULL,
    reportOutputDoc_id     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE scan(
    id                   INT              AUTO_INCREMENT,
    isCompleted          CHAR(1)          DEFAULT 'N',
    updateDate           DATETIME,
    certification        VARCHAR(20),
    auditUpdated         CHAR(1)          DEFAULT 'N',
    scaLabel             VARCHAR(2000),
    scaBuildId           VARCHAR(255),
    hostName             VARCHAR(255),
    startDate            BIGINT,
    elapsedTime          INT,
    hasIssue             CHAR(1)          DEFAULT 'Y',
    updated              CHAR(1)          DEFAULT 'Y',
    scaFiles             INT,
    executableLoc        INT,
    totalLoc             INT,
    engineType           VARCHAR(20)      NOT NULL,
    engineVersion        VARCHAR(80),
    guid                 VARCHAR(255),
    projectLabel         VARCHAR(255),
    versionLabel         VARCHAR(255),
    projectVersion_id    INT              NOT NULL,
    artifact_id          INT              NOT NULL,
    objectVersion        INT,
    migrated             VARCHAR(18)      DEFAULT 'N',
    serverVersion        FLOAT(8, 0),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE scan_finding(
    scan_id              INT             NOT NULL,
    findingGuid          VARCHAR(255)    NOT NULL,
    severity             FLOAT(8, 2),
    remediationEffort    FLOAT(12, 2),
    PRIMARY KEY (scan_id, findingGuid)
)ENGINE=INNODB;

CREATE TABLE scan_issue(
    scan_id                INT              NOT NULL,
    issueInstanceId        VARCHAR(80)      NOT NULL,
    accuracy               FLOAT(8, 0),
    fileName               VARCHAR(500),
    shortFileName          VARCHAR(255),
    severity               FLOAT(8, 2),
    ruleGuid               VARCHAR(120),
    confidence             FLOAT(8, 2),
    kingdom                VARCHAR(80),
    issueType              VARCHAR(120),
    issueSubtype           VARCHAR(180),
    analyzer               VARCHAR(80),
    lineNumber             INT,
    taintFlag              VARCHAR(255),
    packageName            VARCHAR(255),
    functionName           VARCHAR(1024),
    className              VARCHAR(255),
    issueAbstract          TEXT,
    friority               VARCHAR(20),
    engineType             VARCHAR(20),
    audienceSet            VARCHAR(100),
    replaceStore           BLOB,
    snippetId              VARCHAR(512),
    url                    VARCHAR(1000),
    category               VARCHAR(300),
    source                 VARCHAR(255),
    sourceContext          VARCHAR(1000),
    sourceFile             VARCHAR(255),
    sink                   VARCHAR(1000),
    sinkContext            VARCHAR(1000),
    userName               VARCHAR(255),
    owasp2004              VARCHAR(120),
    owasp2007              VARCHAR(120),
    cwe                    VARCHAR(120),
    findingGuid            VARCHAR(500),
    remediationConstant    FLOAT(8, 2),
    likelihood             FLOAT(8, 0),
    impact                 FLOAT(8, 0),
    sans25                 VARCHAR(120),
    wasc                   VARCHAR(120),
    stig                   VARCHAR(120),
    pci11                  VARCHAR(120),
    pci12                  VARCHAR(120),
    rtaCovered             VARCHAR(120),
    probability            FLOAT(8, 0),
    PRIMARY KEY (scan_id, issueInstanceId)
)ENGINE=INNODB;

CREATE TABLE scan_rulepack(
    scan_id            INT             NOT NULL,
    rulepackGuid       VARCHAR(255)    NOT NULL,
    rulepackVersion    VARCHAR(255)    NOT NULL,
    rulepackName       VARCHAR(255),
    rulepackSku        VARCHAR(255),
    PRIMARY KEY (scan_id, rulepackGuid, rulepackVersion)
)ENGINE=INNODB;

CREATE TABLE sdlhistory(
    id              INT            AUTO_INCREMENT,
    creationTime    DATETIME,
    entityType      VARCHAR(20),
    stateType       VARCHAR(20),
    stateValue      VARCHAR(20),
    snapshot_id     INT            NOT NULL,
    entityCount     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE securityentity(
    id               INT    AUTO_INCREMENT,
    entityTypeId     INT    NOT NULL,
    objectVersion    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE seedhistory(
    id                  INT             AUTO_INCREMENT,
    bundleIdentifier    VARCHAR(255),
    bundleVersion       VARCHAR(255),
    seedDate            DATETIME,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE snapshot(
    id                   INT             AUTO_INCREMENT,
    startDate            DATETIME,
    finishDate           DATETIME,
    projectVersion_id    INT             NOT NULL,
    triggerType          VARCHAR(255),
    triggerEntityId      INT,
    auditBlob_id         INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE sourcefile(
    checksum    VARCHAR(255)    NOT NULL,
    fileBlob    LONGBLOB,
    PRIMARY KEY (checksum)
)ENGINE=INNODB;

CREATE TABLE sourcefilemap(
    projectVersion_id    INT             NOT NULL,
    filePath             VARCHAR(255)    NOT NULL,
    scan_id              INT             NOT NULL,
    crossRef             MEDIUMBLOB,
    checksum             VARCHAR(255),
    PRIMARY KEY (projectVersion_id, filePath, scan_id)
)ENGINE=INNODB;

CREATE TABLE stacktrace(
    checksum     VARCHAR(255)    NOT NULL,
    traceBody    TEXT,
    PRIMARY KEY (checksum)
)ENGINE=INNODB;

CREATE TABLE taskcomment(
    taskInstance_id    INT             NOT NULL,
    commentTime        DATETIME        NOT NULL,
    userName           VARCHAR(255),
    commentText        TEXT,
    commentType        VARCHAR(20),
    PRIMARY KEY (taskInstance_id, commentTime)
)ENGINE=INNODB;

CREATE TABLE taskinstance(
    id                     INT             AUTO_INCREMENT,
    name                   VARCHAR(255),
    description            TEXT,
    seqNumber              INT,
    objectVersion          INT,
    signOffState           VARCHAR(20)     NOT NULL,
    signOffDate            DATETIME,
    signOffUser            VARCHAR(255),
    workOwner              VARCHAR(255),
    projectVersion_id      INT             NOT NULL,
    activityInstance_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE timelapse_event(
    eventLog_id            INT    NOT NULL,
    activityInstance_id    INT    NOT NULL,
    PRIMARY KEY (eventLog_id, activityInstance_id)
)ENGINE=INNODB;

CREATE TABLE timelapseactivity(
    id           INT            NOT NULL,
    eventType    VARCHAR(20),
    timeLapse    INT,
    unit         VARCHAR(20),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE timelapseai(
    id                 INT            NOT NULL,
    eventType          VARCHAR(20),
    timeLapse          INT,
    unit               VARCHAR(20),
    lastEventLog_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE user_permission(
    user_id          INT    NOT NULL,
    permission_id    INT    NOT NULL,
    pt_id            INT    NOT NULL,
    PRIMARY KEY (user_id, permission_id, pt_id)
)ENGINE=INNODB;

CREATE TABLE user_pi(
    user_id    INT    NOT NULL,
    pi_id      INT    NOT NULL,
    pt_id      INT    NOT NULL,
    PRIMARY KEY (user_id, pi_id, pt_id)
)ENGINE=INNODB;

CREATE TABLE user_pt(
    user_id    INT    NOT NULL,
    pt_id      INT    NOT NULL,
    PRIMARY KEY (user_id, pt_id)
)ENGINE=INNODB;

CREATE TABLE userpreference(
    id                        INT             AUTO_INCREMENT,
    userName                  VARCHAR(255),
    projectVersionListMode    VARCHAR(255),
    email                     VARCHAR(255),
    emailAlerts               CHAR(1)         DEFAULT 'Y',
    dateFormat                VARCHAR(20),
    timeFormat                VARCHAR(20),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE variable(
    id                INT              AUTO_INCREMENT,
    guid              VARCHAR(255)     NOT NULL,
    name              VARCHAR(255),
    description       VARCHAR(2000),
    searchString      VARCHAR(2000),
    objectVersion     INT,
    publishVersion    INT,
    variableType      VARCHAR(20),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE variablehistory(
    id               INT         AUTO_INCREMENT,
    creationTime     DATETIME,
    variableValue    INT,
    variable_id      INT         NOT NULL,
    snapshot_id      INT         NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE variableinstance(
    variable_id      INT              NOT NULL,
    ai_id            INT              NOT NULL,
    name             VARCHAR(255),
    description      VARCHAR(2000),
    searchString     VARCHAR(2000),
    variableValue    INT,
    PRIMARY KEY (variable_id, ai_id)
)ENGINE=INNODB;

CREATE UNIQUE INDEX activity_guid_key ON activity(guid);

CREATE INDEX ai_proj ON activityinstance(projectVersion_id);

CREATE INDEX ai_ri ON activityinstance(requirementInstance_id);

CREATE INDEX ac_token ON agentcredential(token);

CREATE INDEX ac_username ON agentcredential(userName);

CREATE INDEX alert_proj ON alerthistory(projectVersion_id, userName);

CREATE INDEX appruleRA ON applicationassignmentrule(runtimeApplication_id);

CREATE INDEX artifact_proj ON artifact(projectVersion_id);

CREATE UNIQUE INDEX attr_altley ON attr(guid);

CREATE UNIQUE INDEX attr_lookup_altkey ON attrlookup(attrGuid, lookupIndex);

CREATE UNIQUE INDEX AuditCommentAltKey ON auditcomment(issue_id, auditTime);

CREATE UNIQUE INDEX AuditHistoryAltKey ON audithistory(issue_id, attrGuid, auditTime);

CREATE INDEX audithistory_altkey2 ON audithistory(projectVersion_id, attrGuid, auditTime);

CREATE INDEX auditValueSearch_altkey ON auditvalue(projectVersion_id, attrGuid, attrValue);

CREATE UNIQUE INDEX daName_altkey ON documentartifact(projectVersion_id, name);

CREATE UNIQUE INDEX activitydocumentguid ON documentdef(guid);

CREATE UNIQUE INDEX IDX_EMM_NAME ON entitytype(entityName);

CREATE INDEX el_proj_type ON eventlogentry(projectVersion_id, eventType);

CREATE UNIQUE INDEX filterset_altkey_1 ON filterset(projectVersion_id, guid);

CREATE UNIQUE INDEX folder_altkey ON folder(projectVersion_id, guid);

CREATE UNIQUE INDEX fortifyuseruk_1_1 ON fortifyuser(userName);

CREATE INDEX HOST_HN ON host(hostName);

CREATE INDEX HOST_FED ON host(federation_id);

CREATE INDEX HLM_HID ON hostlogmessage(host_id);

CREATE INDEX sessionGuid ON idgenerator(sessionGuid);

CREATE INDEX iidm_proj ON iidmigration(projectVersion_id);

CREATE UNIQUE INDEX Issue_Alt_Key ON issue(projectVersion_id, issueInstanceId);

CREATE UNIQUE INDEX IssueAltKeyWithEngineType ON issue(projectVersion_id, engineType, issueInstanceId);

CREATE UNIQUE INDEX IssueProjLastScanAltKey ON issue(projectVersion_id, lastScan_id, issueInstanceId);

CREATE INDEX IssueEngineStatusAltKey ON issue(projectVersion_id, scanStatus, engineType);

CREATE UNIQUE INDEX IssueCacheAltKey ON issuecache(projectVersion_id, filterSet_id, folder_id, issue_id);

CREATE INDEX viewIssueIndex ON issuecache(filterSet_id, hidden, folder_id);

CREATE UNIQUE INDEX measurement_guid_key ON measurement(guid);

CREATE INDEX mh_ss ON measurementhistory(snapshot_id, measurement_id);

CREATE UNIQUE INDEX metarule_guid_key ON metadatarule(guid);

CREATE UNIQUE INDEX metadef_guid_key ON metadef(guid);

CREATE INDEX mo_md ON metaoption(metaDef_id);

CREATE UNIQUE INDEX metainstance_altkey ON metavalue(projectVersion_id, metaDef_id);

CREATE UNIQUE INDEX UK_PERMISSION_NAME ON permission(name);

CREATE INDEX pi_p_e ON permissioninstance(permission_id, entityInstanceId);

CREATE UNIQUE INDEX UK_PT_NAME ON permissiontemplate(name);

CREATE UNIQUE INDEX PERSONA_GUID ON persona(guid);

CREATE INDEX pref_pod_alt ON pref_pod(pref_id, pod_id);

CREATE UNIQUE INDEX ProjNameUniqueKey ON project(name);

CREATE UNIQUE INDEX pt_guid_key ON projecttemplate(guid);

CREATE UNIQUE INDEX UK_APP_NAME ON projectversion(project_id, name);

CREATE UNIQUE INDEX pva_reverse ON projectversion_alert(projectVersion_id, alert_id);

CREATE INDEX pr_proj_guid ON projectversion_rule(projectVersion_id, ruleGuid);

CREATE INDEX pr_proj_engine ON projectversion_rule(projectVersion_id, engineType);

CREATE UNIQUE INDEX vender_sr ON publishedreport(vendorTenantId, savedReport_id);

CREATE UNIQUE INDEX UK_REPORT_NAME ON reportdefinition(name);

CREATE UNIQUE INDEX UK_REPORTP_NAME ON reportparameter(reportDefinition_id, paramName);

CREATE INDEX req_rt ON requirement(requirementTemplate_id);

CREATE INDEX ri_proj_req ON requirementinstance(projectVersion_id, requirement_id);

CREATE UNIQUE INDEX rt_guid_key ON requirementtemplate(guid);

CREATE INDEX rd_rp ON ruledescription(rulepack_id);

CREATE UNIQUE INDEX rp_guidver_key ON rulepack(rulepackGuid, versionNumber);

CREATE INDEX RUNTIMEALERT_REID ON runtimealert(runtimeEvent_id);

CREATE INDEX RE_RAID ON runtimeevent(runtimeApplication_id, creationDate);

CREATE INDEX RE_DATE ON runtimeevent(creationDate, runtimeApplication_id);

CREATE INDEX REA_RAID ON runtimeeventarchive(runtimeApplication_id);

CREATE INDEX RNA_RNASID ON runtimenamedattr(runtimeNamedAttrSet_id);

CREATE INDEX RNAS_ALTID ON runtimenamedattrset(attributeSetId);

CREATE INDEX scan_proj_date ON scan(projectVersion_id, engineType, updateDate);

CREATE INDEX scan_arti ON scan(artifact_id);

CREATE INDEX sh_ss ON sdlhistory(snapshot_id, entityType, stateType);

CREATE INDEX ss_proj_date ON snapshot(projectVersion_id, startDate);

CREATE INDEX ti_proj ON taskinstance(projectVersion_id);

CREATE INDEX ti_ai ON taskinstance(activityInstance_id);

CREATE UNIQUE INDEX UserPrefUserNameKey ON userpreference(userName);

CREATE UNIQUE INDEX variable_guid_key ON variable(guid);

CREATE INDEX vh_ss ON variablehistory(snapshot_id, variable_id);

ALTER TABLE activity_persona ADD CONSTRAINT RefActPersona 
    FOREIGN KEY (activity_id)
    REFERENCES activity(id) ON DELETE CASCADE;

ALTER TABLE activity_persona ADD CONSTRAINT RefPersonaActPersona 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id) ON DELETE CASCADE;

ALTER TABLE activitycomment ADD CONSTRAINT RefAIActComment 
    FOREIGN KEY (activityInstance_id)
    REFERENCES activityinstance(id) ON DELETE CASCADE;

ALTER TABLE activityinstance ADD CONSTRAINT RefActAi 
    FOREIGN KEY (activity_id)
    REFERENCES activity(id);

ALTER TABLE activityinstance ADD CONSTRAINT RefRIAI 
    FOREIGN KEY (requirementInstance_id)
    REFERENCES requirementinstance(id) ON DELETE CASCADE;

ALTER TABLE activitysignoff ADD CONSTRAINT RefAIActSignOff 
    FOREIGN KEY (activityInstance_id)
    REFERENCES activityinstance(id) ON DELETE CASCADE;

ALTER TABLE activitysignoff ADD CONSTRAINT RefPersonaActSignOff 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id);

ALTER TABLE alert_role ADD CONSTRAINT RefAlertRole 
    FOREIGN KEY (alert_id)
    REFERENCES alert(id) ON DELETE CASCADE;

ALTER TABLE alerthistory ADD CONSTRAINT RefAlertHis 
    FOREIGN KEY (alert_id)
    REFERENCES alert(id) ON DELETE CASCADE;

ALTER TABLE alerthistory ADD CONSTRAINT RefAppEntAlertHis 
    FOREIGN KEY (projectVersion_id)
    REFERENCES applicationentity(id) ON DELETE CASCADE;

ALTER TABLE alerttrigger ADD CONSTRAINT RefAlertTrigger 
    FOREIGN KEY (alert_id)
    REFERENCES alert(id) ON DELETE CASCADE;

ALTER TABLE applicationassignmentrule ADD CONSTRAINT RefRuntimeAppAssignRule 
    FOREIGN KEY (runtimeApplication_id)
    REFERENCES runtimeapplication(id) ON DELETE CASCADE;

ALTER TABLE applicationassignmentrule_host ADD CONSTRAINT RefAppRuleHost 
    FOREIGN KEY (applicationAssignmentRule_id)
    REFERENCES applicationassignmentrule(id) ON DELETE CASCADE;

ALTER TABLE applicationassignmentrule_host ADD CONSTRAINT RefHostAppAssignRuleHost 
    FOREIGN KEY (host_id)
    REFERENCES host(id) ON DELETE CASCADE;

ALTER TABLE artifact ADD CONSTRAINT RefPVArti 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE attrlookup ADD CONSTRAINT RefAttrAttrLookup 
    FOREIGN KEY (attr_id)
    REFERENCES attr(id) ON DELETE CASCADE;

ALTER TABLE auditcomment ADD CONSTRAINT RefIssAuditComment 
    FOREIGN KEY (issue_id)
    REFERENCES issue(id) ON DELETE CASCADE;

ALTER TABLE audithistory ADD CONSTRAINT RefIssAuditHis 
    FOREIGN KEY (issue_id)
    REFERENCES issue(id) ON DELETE CASCADE;

ALTER TABLE auditvalue ADD CONSTRAINT RefIssAuditVal 
    FOREIGN KEY (issue_id)
    REFERENCES issue(id) ON DELETE CASCADE;

ALTER TABLE consoleeventhandler ADD CONSTRAINT RefRuntimeConfEventHandler 
    FOREIGN KEY (runtimeConfiguration_id)
    REFERENCES runtimeconfiguration(id) ON DELETE CASCADE;

ALTER TABLE controller ADD CONSTRAINT RefKeyKeeperController 
    FOREIGN KEY (controllerKeyKeeper_id)
    REFERENCES controllerkeykeeper(id);

ALTER TABLE documentactivity ADD CONSTRAINT RefActDocAct 
    FOREIGN KEY (id)
    REFERENCES activity(id) ON DELETE CASCADE;

ALTER TABLE documentai ADD CONSTRAINT RefAIDocAI 
    FOREIGN KEY (id)
    REFERENCES activityinstance(id) ON DELETE CASCADE;

ALTER TABLE documentartifact ADD CONSTRAINT RefPVDocArti 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE documentartifact_def ADD CONSTRAINT RefDocArtiDocArtiDef 
    FOREIGN KEY (documentArtifact_id)
    REFERENCES documentartifact(id) ON DELETE CASCADE;

ALTER TABLE documentdefinstance ADD CONSTRAINT RefDocAIDocDI 
    FOREIGN KEY (activityInstance_id)
    REFERENCES documentai(id) ON DELETE CASCADE;

ALTER TABLE dynamicassessment ADD CONSTRAINT RefPVDynaAss 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE eventlogentry ADD CONSTRAINT RefAppEntEventLog 
    FOREIGN KEY (projectVersion_id)
    REFERENCES applicationentity(id) ON DELETE SET NULL;

ALTER TABLE federation ADD CONSTRAINT RefRuntimeConfFed 
    FOREIGN KEY (runtimeConfiguration_id)
    REFERENCES runtimeconfiguration(id);

ALTER TABLE filterset ADD CONSTRAINT RefPVFilterSet 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE finding ADD CONSTRAINT RefPVFinding 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE folder ADD CONSTRAINT RefPVFolder 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE foldercountcache ADD CONSTRAINT RefPVFolderCountCache 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE fortifyuser ADD CONSTRAINT RefSEFortifyUser 
    FOREIGN KEY (id)
    REFERENCES securityentity(id) ON DELETE CASCADE;

ALTER TABLE fpr_scan ADD CONSTRAINT RefArtiFPRScan 
    FOREIGN KEY (artifact_id)
    REFERENCES artifact(id) ON DELETE CASCADE;

ALTER TABLE host ADD CONSTRAINT RefControllerHost 
    FOREIGN KEY (controller_id)
    REFERENCES controller(id) ON DELETE CASCADE;

ALTER TABLE host ADD CONSTRAINT RefFedHost 
    FOREIGN KEY (federation_id)
    REFERENCES federation(id);

ALTER TABLE hostlogmessage ADD CONSTRAINT RefHostLogMsg 
    FOREIGN KEY (host_id)
    REFERENCES host(id) ON DELETE CASCADE;

ALTER TABLE iidmapping ADD CONSTRAINT RefIIDMigMapping 
    FOREIGN KEY (migration_id)
    REFERENCES iidmigration(id) ON DELETE CASCADE;

ALTER TABLE iidmigration ADD CONSTRAINT RefPVIIDMig 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE ldapentity ADD CONSTRAINT RefSELDAPEnt 
    FOREIGN KEY (id)
    REFERENCES securityentity(id) ON DELETE CASCADE;

ALTER TABLE measurement_variable ADD CONSTRAINT RefMeasVar 
    FOREIGN KEY (measurement_id)
    REFERENCES measurement(id) ON DELETE CASCADE;

ALTER TABLE measurement_variable ADD CONSTRAINT RefVarMeasVar 
    FOREIGN KEY (variable_id)
    REFERENCES variable(id) ON DELETE CASCADE;

ALTER TABLE measurementhistory ADD CONSTRAINT RefMeasHis 
    FOREIGN KEY (measurement_id)
    REFERENCES measurement(id) ON DELETE CASCADE;

ALTER TABLE measurementhistory ADD CONSTRAINT RefSnapshotMeasHis 
    FOREIGN KEY (snapshot_id)
    REFERENCES snapshot(id) ON DELETE CASCADE;

ALTER TABLE measurementinstance ADD CONSTRAINT RefMeasMI 
    FOREIGN KEY (measurement_id)
    REFERENCES measurement(id);

ALTER TABLE measurementinstance ADD CONSTRAINT RefProjStatAIMI 
    FOREIGN KEY (activityInstance_id)
    REFERENCES projectstateai(id) ON DELETE CASCADE;

ALTER TABLE metadef ADD CONSTRAINT RefMetaDefRecur 
    FOREIGN KEY (parent_id)
    REFERENCES metadef(id);

ALTER TABLE metadef_t ADD CONSTRAINT RefMetaDefT 
    FOREIGN KEY (metaDef_id)
    REFERENCES metadef(id) ON DELETE CASCADE;

ALTER TABLE metaoption ADD CONSTRAINT RefMetaDefOpt 
    FOREIGN KEY (metaDef_id)
    REFERENCES metadef(id) ON DELETE CASCADE;

ALTER TABLE metaoption_t ADD CONSTRAINT RefMetaOptT 
    FOREIGN KEY (metaOption_id)
    REFERENCES metaoption(id) ON DELETE CASCADE;

ALTER TABLE metavalue ADD CONSTRAINT RefAppEntMetaValue 
    FOREIGN KEY (projectVersion_id)
    REFERENCES applicationentity(id) ON DELETE CASCADE;

ALTER TABLE metavalue ADD CONSTRAINT RefMetaDefMV 
    FOREIGN KEY (metaDef_id)
    REFERENCES metadef(id);

ALTER TABLE metavalueselection ADD CONSTRAINT RefMetaOptMVSel 
    FOREIGN KEY (metaOption_id)
    REFERENCES metaoption(id);

ALTER TABLE metavalueselection ADD CONSTRAINT RefMetaValMVSel 
    FOREIGN KEY (metaValue_id)
    REFERENCES metavalue(id) ON DELETE CASCADE;

ALTER TABLE payloadartifact ADD CONSTRAINT RefPVPLArti 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE payloadentry ADD CONSTRAINT RefPLArtiPLEntry 
    FOREIGN KEY (artifact_id)
    REFERENCES payloadartifact(id) ON DELETE CASCADE;

ALTER TABLE payloadmessage ADD CONSTRAINT RefPLArtiPLMsg 
    FOREIGN KEY (artifact_id)
    REFERENCES payloadartifact(id) ON DELETE CASCADE;

ALTER TABLE permissioninstance ADD CONSTRAINT RefPerPI 
    FOREIGN KEY (permission_id)
    REFERENCES permission(id) ON DELETE CASCADE;

ALTER TABLE personaassignment ADD CONSTRAINT RefPersonaAssign 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id);

ALTER TABLE personaassignment ADD CONSTRAINT RefPVPersonaAssign 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE pref_pod ADD CONSTRAINT RefPodPref 
    FOREIGN KEY (pod_id)
    REFERENCES pod(id) ON DELETE CASCADE;

ALTER TABLE pref_pod ADD CONSTRAINT RefUserPrefPrefPod 
    FOREIGN KEY (pref_id)
    REFERENCES userpreference(id) ON DELETE CASCADE;

ALTER TABLE pref_projectversion ADD CONSTRAINT RefPVPrefPV 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE pref_projectversion ADD CONSTRAINT UserPrefPrefPV 
    FOREIGN KEY (pref_id)
    REFERENCES userpreference(id) ON DELETE CASCADE;

ALTER TABLE projectstateactivity ADD CONSTRAINT RefActProjStatAct 
    FOREIGN KEY (id)
    REFERENCES activity(id) ON DELETE CASCADE;

ALTER TABLE projectstateactivity ADD CONSTRAINT RefMeasProjStatAct 
    FOREIGN KEY (measurement_id)
    REFERENCES measurement(id);

ALTER TABLE projectstateai ADD CONSTRAINT RefAIProjStatAI 
    FOREIGN KEY (id)
    REFERENCES activityinstance(id) ON DELETE CASCADE;

ALTER TABLE projectstateai ADD CONSTRAINT RefMeasProjStatAI 
    FOREIGN KEY (measurement_id)
    REFERENCES measurement(id);

ALTER TABLE projecttemplate_attr ADD CONSTRAINT RefPTAttr 
    FOREIGN KEY (projectTemplate_id)
    REFERENCES projecttemplate(id) ON DELETE CASCADE;

ALTER TABLE projectversion_alert ADD CONSTRAINT RefAppEntAlert 
    FOREIGN KEY (projectVersion_id)
    REFERENCES applicationentity(id) ON DELETE CASCADE;

ALTER TABLE projectversion_alert ADD CONSTRAINT RefPVAlert 
    FOREIGN KEY (alert_id)
    REFERENCES alert(id) ON DELETE CASCADE;

ALTER TABLE projectversion_rule ADD CONSTRAINT RefPVPVRule 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE projectversion_rule ADD CONSTRAINT RefRuleDescPVRule 
    FOREIGN KEY (rule_id)
    REFERENCES ruledescription(id) ON DELETE CASCADE;

ALTER TABLE projectversiondependency ADD CONSTRAINT RefPVDepChild 
    FOREIGN KEY (childProjectVersion_id)
    REFERENCES projectversion(id);

ALTER TABLE projectversiondependency ADD CONSTRAINT RefPVDepParent 
    FOREIGN KEY (parentProjectVersion_id)
    REFERENCES projectversion(id);

ALTER TABLE pt_permission ADD CONSTRAINT RefPerPTPer 
    FOREIGN KEY (permission_id)
    REFERENCES permission(id) ON DELETE CASCADE;

ALTER TABLE pt_permission ADD CONSTRAINT RefPTPer 
    FOREIGN KEY (pt_id)
    REFERENCES permissiontemplate(id) ON DELETE CASCADE;

ALTER TABLE publishaction ADD CONSTRAINT RefPubRepPubAct 
    FOREIGN KEY (publishedReport_id)
    REFERENCES publishedreport(id) ON DELETE CASCADE;

ALTER TABLE report_projectversion ADD CONSTRAINT RefSavedRepPV 
    FOREIGN KEY (savedReport_id)
    REFERENCES savedreport(id) ON DELETE CASCADE;

ALTER TABLE reportparameter ADD CONSTRAINT RefRepDefRepParam 
    FOREIGN KEY (reportDefinition_id)
    REFERENCES reportdefinition(id) ON DELETE CASCADE;

ALTER TABLE requirement ADD CONSTRAINT RefRTRep 
    FOREIGN KEY (requirementTemplate_id)
    REFERENCES requirementtemplate(id);

ALTER TABLE requirement_activity ADD CONSTRAINT RefActReqAct 
    FOREIGN KEY (activity_id)
    REFERENCES activity(id) ON DELETE CASCADE;

ALTER TABLE requirement_activity ADD CONSTRAINT RefReqAct 
    FOREIGN KEY (requirement_id)
    REFERENCES requirement(id) ON DELETE CASCADE;

ALTER TABLE requirement_persona ADD CONSTRAINT RefPersonaReqPerson 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id);

ALTER TABLE requirement_persona ADD CONSTRAINT RefReqPerson 
    FOREIGN KEY (requirement_id)
    REFERENCES requirement(id) ON DELETE CASCADE;

ALTER TABLE requirementcomment ADD CONSTRAINT RefRIReqComment 
    FOREIGN KEY (requirementInstance_id)
    REFERENCES requirementinstance(id) ON DELETE CASCADE;

ALTER TABLE requirementinstance ADD CONSTRAINT RefPVRI 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE requirementinstance ADD CONSTRAINT RefReqRI 
    FOREIGN KEY (requirement_id)
    REFERENCES requirement(id);

ALTER TABLE requirementsignoff ADD CONSTRAINT RefPersonaReqSignOff 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id);

ALTER TABLE requirementsignoff ADD CONSTRAINT RefRIReqSignOff 
    FOREIGN KEY (requirementInstance_id)
    REFERENCES requirementinstance(id) ON DELETE CASCADE;

ALTER TABLE requirementtemplate_persona ADD CONSTRAINT RefPersonaRTPersona 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id);

ALTER TABLE requirementtemplate_persona ADD CONSTRAINT RefRTPersona 
    FOREIGN KEY (requirementTemplate_id)
    REFERENCES requirementtemplate(id) ON DELETE CASCADE;

ALTER TABLE requirementtemplatecomment ADD CONSTRAINT RefRTIRTComment 
    FOREIGN KEY (projectVersion_id)
    REFERENCES requirementtemplateinstance(projectVersion_id) ON DELETE CASCADE;

ALTER TABLE requirementtemplateinstance ADD CONSTRAINT RefPVRTI 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE requirementtemplateinstance ADD CONSTRAINT RefRTRTI 
    FOREIGN KEY (requirementTemplate_id)
    REFERENCES requirementtemplate(id);

ALTER TABLE requirementtemplatesignoff ADD CONSTRAINT RefPersonaRTSignOff 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id);

ALTER TABLE requirementtemplatesignoff ADD CONSTRAINT RefRTIRTSignOff 
    FOREIGN KEY (projectVersion_id)
    REFERENCES requirementtemplateinstance(projectVersion_id) ON DELETE CASCADE;

ALTER TABLE rtassignment ADD CONSTRAINT RefMetaRuleRTAssign 
    FOREIGN KEY (metadataRule_id)
    REFERENCES metadatarule(id) ON DELETE CASCADE;

ALTER TABLE rtassignment ADD CONSTRAINT RefRTAssign 
    FOREIGN KEY (requirementTemplate_id)
    REFERENCES requirementtemplate(id);

ALTER TABLE rule_t ADD CONSTRAINT RefRuleDescT 
    FOREIGN KEY (id)
    REFERENCES ruledescription(id) ON DELETE CASCADE;

ALTER TABLE runtimealert ADD CONSTRAINT RefRERuntimeAlert 
    FOREIGN KEY (runtimeEvent_id)
    REFERENCES runtimeevent(id) ON DELETE CASCADE;

ALTER TABLE runtimeconfig_rulepack ADD CONSTRAINT RefRPRuntimeConfRP 
    FOREIGN KEY (rulepack_id)
    REFERENCES rulepack(id) ON DELETE CASCADE;

ALTER TABLE runtimeconfig_rulepack ADD CONSTRAINT RefRuntimeConfRP 
    FOREIGN KEY (runtimeConfiguration_id)
    REFERENCES runtimeconfiguration(id) ON DELETE CASCADE;

ALTER TABLE runtimeevent ADD CONSTRAINT RefHostRE 
    FOREIGN KEY (host_id)
    REFERENCES host(id) ON DELETE CASCADE;

ALTER TABLE runtimeeventarchive ADD CONSTRAINT RefDocInfoREArch 
    FOREIGN KEY (documentInfo_id)
    REFERENCES documentinfo(id);

ALTER TABLE runtimeeventattr ADD CONSTRAINT RefREREAttr 
    FOREIGN KEY (runtimeEvent_id)
    REFERENCES runtimeevent(id) ON DELETE CASCADE;

ALTER TABLE runtimenamedattr ADD CONSTRAINT RefRNASetRNA 
    FOREIGN KEY (runtimeNamedAttrSet_id)
    REFERENCES runtimenamedattrset(id);

ALTER TABLE runtimesetting ADD CONSTRAINT RefRuntimeConfSetting 
    FOREIGN KEY (runtimeConfiguration_id)
    REFERENCES runtimeconfiguration(id) ON DELETE CASCADE;

ALTER TABLE savedevidence ADD CONSTRAINT RefPVSavedEvidence 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE savedreport ADD CONSTRAINT RefRepDefSavedRep 
    FOREIGN KEY (reportDefinition_id)
    REFERENCES reportdefinition(id);

ALTER TABLE scan ADD CONSTRAINT RefPVScan 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE scan_finding ADD CONSTRAINT RefScanFinding 
    FOREIGN KEY (scan_id)
    REFERENCES scan(id) ON DELETE CASCADE;

ALTER TABLE scan_rulepack ADD CONSTRAINT RefScanRP 
    FOREIGN KEY (scan_id)
    REFERENCES scan(id) ON DELETE CASCADE;

ALTER TABLE sdlhistory ADD CONSTRAINT RefSnapshotSDLHis 
    FOREIGN KEY (snapshot_id)
    REFERENCES snapshot(id) ON DELETE CASCADE;

ALTER TABLE snapshot ADD CONSTRAINT RefPVSnapshot 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE sourcefilemap ADD CONSTRAINT RefScanSrcFileMap 
    FOREIGN KEY (scan_id)
    REFERENCES scan(id) ON DELETE CASCADE;

ALTER TABLE taskcomment ADD CONSTRAINT RefTITaskComment 
    FOREIGN KEY (taskInstance_id)
    REFERENCES taskinstance(id) ON DELETE CASCADE;

ALTER TABLE taskinstance ADD CONSTRAINT RefAITaskAI 
    FOREIGN KEY (activityInstance_id)
    REFERENCES activityinstance(id) ON DELETE CASCADE;

ALTER TABLE timelapse_event ADD CONSTRAINT RefTimeAITimeEvent 
    FOREIGN KEY (activityInstance_id)
    REFERENCES timelapseai(id) ON DELETE CASCADE;

ALTER TABLE timelapseactivity ADD CONSTRAINT RefActTimeAct 
    FOREIGN KEY (id)
    REFERENCES activity(id) ON DELETE CASCADE;

ALTER TABLE timelapseai ADD CONSTRAINT RefAITimeAI 
    FOREIGN KEY (id)
    REFERENCES activityinstance(id) ON DELETE CASCADE;

ALTER TABLE user_permission ADD CONSTRAINT RefPerUserPer 
    FOREIGN KEY (permission_id)
    REFERENCES permission(id) ON DELETE CASCADE;

ALTER TABLE user_permission ADD CONSTRAINT RefPTUserPer 
    FOREIGN KEY (pt_id)
    REFERENCES permissiontemplate(id) ON DELETE CASCADE;

ALTER TABLE user_permission ADD CONSTRAINT RefSEUserPer 
    FOREIGN KEY (user_id)
    REFERENCES securityentity(id) ON DELETE CASCADE;

ALTER TABLE user_pi ADD CONSTRAINT RefPIUPI 
    FOREIGN KEY (pi_id)
    REFERENCES permissioninstance(id) ON DELETE CASCADE;

ALTER TABLE user_pi ADD CONSTRAINT RefPTUserPI 
    FOREIGN KEY (pt_id)
    REFERENCES permissiontemplate(id) ON DELETE CASCADE;

ALTER TABLE user_pi ADD CONSTRAINT RefSEUserPI 
    FOREIGN KEY (user_id)
    REFERENCES securityentity(id) ON DELETE CASCADE;

ALTER TABLE user_pt ADD CONSTRAINT RefPTUserPT 
    FOREIGN KEY (pt_id)
    REFERENCES permissiontemplate(id) ON DELETE CASCADE;

ALTER TABLE user_pt ADD CONSTRAINT RefSEUserPT 
    FOREIGN KEY (user_id)
    REFERENCES securityentity(id) ON DELETE CASCADE;

ALTER TABLE variablehistory ADD CONSTRAINT RefSnapshotVarHis 
    FOREIGN KEY (snapshot_id)
    REFERENCES snapshot(id) ON DELETE CASCADE;

ALTER TABLE variablehistory ADD CONSTRAINT RefVarHis 
    FOREIGN KEY (variable_id)
    REFERENCES variable(id) ON DELETE CASCADE;

ALTER TABLE variableinstance ADD CONSTRAINT RefProjStatAIVI 
    FOREIGN KEY (ai_id)
    REFERENCES projectstateai(id) ON DELETE CASCADE;

ALTER TABLE variableinstance ADD CONSTRAINT RefVarVI 
    FOREIGN KEY (variable_id)
    REFERENCES variable(id);

CREATE VIEW ruleview AS
SELECT p.projectVersion_id projectVersion_id, r.id id, p.ruleGuid ruleGuid, r.rulepack_id rulepack_id, t.lang lang,
t.detail detail, t.recommendation recommendation, t.ruleAbstract ruleAbstract,
t.rawDetail rawDetail, t.rawRecommendation rawRecommendation, t.rawRuleAbstract rawRuleAbstract
FROM ruledescription r, rule_t t, projectversion_rule p
where r.id = t.id AND p.rule_id = r.id;

CREATE VIEW audithistoryview AS
SELECT
h.issue_id issue_id,
h.seqNumber seqNumber,
h.attrGuid attrGuid,
h.auditTime auditTime,
h.oldValue oldNum,
h.newValue newNum,
CASE WHEN a.guid='userAssignment' THEN ou.userName ELSE o.lookupValue END oldString,
CASE WHEN a.guid='userAssignment' THEN nu.userName ELSE n.lookupValue END newString,
h.projectVersion_id projectVersion_id,
h.userName userName,
h.conflict conflict,
a.attrName attrName,
a.defaultValue
from audithistory as h JOIN attr as a ON h.attrGuid=a.guid
LEFT OUTER JOIN attrlookup as n ON a.id=n.attr_id
AND h.newValue=n.lookupIndex
LEFT OUTER JOIN attrlookup o ON a.id=o.attr_id
and h.oldValue=o.lookupIndex
LEFT OUTER JOIN userpreference as nu ON nu.id=h.newValue
LEFT OUTER JOIN userpreference ou ON ou.id=h.oldValue;

CREATE VIEW auditvalueview AS 
 SELECT a.projectVersion_id projectVersion_Id, a.issue_id issue_id, a.attrGuid attrGuid, a.attrValue lookupIndex, l.lookupValue lookupValue, attr.attrName attrName, attr.defaultValue, attr.hidden, l.seqNumber
 from auditvalue a, attr, attrlookup l 
 where a.attrGuid=attr.guid and attr.id=l.attr_id and l.lookupIndex=a.attrValue;

CREATE VIEW metadefview AS 
 SELECT def.id id, def.metaType metaType, def.seqNumber seqNumber, def.required required, def.category category, def.hidden hidden, def.booleanDefault booleanDefault, def.guid guid, def.parent_id parent_id, t.name name, t.description description, t.help help, t.lang lang, def.parentOption_id, def.appEntityType, def.objectVersion, def.publishVersion
 from metadef def, metadef_t t 
 where def.id =  t.metaDef_id  AND t.metaDef_id = def.id;

CREATE VIEW metaoptionview AS
 select op.id id, op.optionIndex optionIndex, op.metaDef_id metaDef_id, op.defaultSelection defaultSelection, op.guid guid , t.name name, t.description description, t.help help, t.lang lang, op.hidden
 from metaoption op, metaoption_t t 
 where op.id =  t.metaOption_id;

create view defaultissueview as
select 
c.folder_id,
i.id,
i.issueinstanceid,
    i.fileName,
    i.shortFileName,
    i.severity,
    i.ruleGuid,
    i.confidence,
    i.kingdom,
    i.issueType,
    i.issueSubtype,
    i.analyzer,
    i.lineNumber,
    i.taintFlag,
    i.packageName,
    i.functionName,
    i.className,
    i.issueAbstract,
    i.friority,
    i.engineType,
    i.scanStatus,
    i.audienceSet,
    i.lastScan_id,
    i.replaceStore,
    i.snippetId,
    i.url,
    i.category,
    i.source,
    i.sourceContext,
    i.sourceFile,
    i.sink,
    i.sinkContext,
    i.userName,
    i.owasp2004,
    i.owasp2007,
    i.cwe,
    i.revision,
    i.audited,
    i.auditedTime,
    i.suppressed,
    i.findingGuid,
    i.issueStatus,
    i.issueState,
    i.dynamicConfidence,
    i.remediationConstant,
    p.id projectVersion_id,
    c.hidden,
    i.likelihood,
    i.impact,
    i.accuracy,
    i.sans25,
    i.wasc,
    i.stig,
    i.pci11,
    i.pci12,
    i.rtaCovered,
    i.probability
from issuecache c, issue i, projectversion p, filterset f
where c.issue_id = i.id
and i.projectversion_id = p.id
and c.filterset_id= f.id
and f.enabled='Y'
and f.filtersettype='user'
and f.projectversion_id = p.id;

create view applicationentityview as
 select a.id id, p.name name,a.appEntityType
 from applicationentity a, projectversion p
 where a.id = p.id
 union 
 select a.id id, r.name name ,a.appEntityType from applicationentity a, runtimeapplication r where a.id = r.id;

create view attrlookupview as
select attr_id ,lookupindex , lookupvalue , attrguid, hidden,seqnumber
from attrlookup
union
select attr_id,-1 lookupindex,'' lookupvalue,attrguid,'Y' hidden,-1 seqnumber
from attrlookup
group by attr_id, attrguid;

DELIMITER //
CREATE PROCEDURE updateExistingWithLatest(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20))BEGIN
        UPDATE issue issue, scan_issue si SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName 
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet, issue.owasp2004=si.owasp2004, issue.owasp2007=si.owasp2007, issue.cwe=si.cwe
        , issue.scanStatus = (CASE WHEN scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.sans25=si.sans25, issue.wasc=si.wasc, issue.stig=si.stig, issue.pci11=si.pci11, issue.pci12=si.pci12, issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id;    
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateDeletedIssues(p_scan_id INT,p_previous_scan_id INT, p_projectVersion_Id INT)BEGIN
        UPDATE issue issue, scan_issue si SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName 
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet, issue.owasp2004=si.owasp2004, issue.owasp2007=si.owasp2007, issue.cwe=si.cwe
        , issue.scanStatus = (CASE WHEN scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.sans25=si.sans25, issue.wasc=si.wasc, issue.stig=si.stig, issue.pci11=si.pci11, issue.pci12=si.pci12, issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.lastScan_id= p_scan_id AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_previous_scan_id;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateRemovedWithUpload(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20), p_scanDate BIGINT)BEGIN
        UPDATE issue issue, scan_issue si, scan scan SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName 
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet, issue.owasp2004=si.owasp2004, issue.owasp2007=si.owasp2007, issue.cwe=si.cwe
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.sans25=si.sans25, issue.wasc=si.wasc, issue.stig=si.stig, issue.pci11=si.pci11, issue.pci12=si.pci12, issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id AND issue.scanStatus='REMOVED' AND 
        issue.lastScan_id = scan.id and scan.startDate < p_scanDate;    
END//
DELIMITER ;

CREATE TABLE QRTZ_JOB_DETAILS
  (
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    JOB_CLASS_NAME   VARCHAR(250) NOT NULL,
    IS_DURABLE VARCHAR(1) NOT NULL,
    IS_VOLATILE VARCHAR(1) NOT NULL,
    IS_STATEFUL VARCHAR(1) NOT NULL,
    REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (JOB_NAME,JOB_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_JOB_LISTENERS
  (
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    JOB_LISTENER VARCHAR(200) NOT NULL,
    PRIMARY KEY (JOB_NAME,JOB_GROUP,JOB_LISTENER),
    FOREIGN KEY (JOB_NAME,JOB_GROUP)
    REFERENCES QRTZ_JOB_DETAILS(JOB_NAME,JOB_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_TRIGGERS
 (
   TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    IS_VOLATILE VARCHAR(1) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    NEXT_FIRE_TIME BIGINT(13) NULL,
    PREV_FIRE_TIME BIGINT(13) NULL,
    PRIORITY INTEGER NULL,
    TRIGGER_STATE VARCHAR(16) NOT NULL,
    TRIGGER_TYPE VARCHAR(8) NOT NULL,
    START_TIME BIGINT(13) NOT NULL,
    END_TIME BIGINT(13) NULL,
    CALENDAR_NAME VARCHAR(200) NULL,
    MISFIRE_INSTR SMALLINT(2) NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_SIMPLE_TRIGGERS
  (
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    REPEAT_COUNT BIGINT(7) NOT NULL,
    REPEAT_INTERVAL BIGINT(12) NOT NULL,
    TIMES_TRIGGERED BIGINT(7) NOT NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_CRON_TRIGGERS
  (
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    CRON_EXPRESSION VARCHAR(200) NOT NULL,
    TIME_ZONE_ID VARCHAR(80),
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_BLOB_TRIGGERS
  (
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    BLOB_DATA BLOB NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_TRIGGER_LISTENERS
  (
    TRIGGER_NAME  VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    TRIGGER_LISTENER VARCHAR(200) NOT NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_LISTENER),
    FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_CALENDARS
  (
    CALENDAR_NAME  VARCHAR(200) NOT NULL,
    CALENDAR BLOB NOT NULL,
    PRIMARY KEY (CALENDAR_NAME)
)ENGINE=INNODB;

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS
  (
    TRIGGER_GROUP  VARCHAR(200) NOT NULL, 
    PRIMARY KEY (TRIGGER_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_FIRED_TRIGGERS
  (
    ENTRY_ID VARCHAR(95) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    IS_VOLATILE VARCHAR(1) NOT NULL,
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    FIRED_TIME BIGINT(13) NOT NULL,
    PRIORITY INTEGER NOT NULL,
    STATE VARCHAR(16) NOT NULL,
    JOB_NAME VARCHAR(200) NULL,
    JOB_GROUP VARCHAR(200) NULL,
    IS_STATEFUL VARCHAR(1) NULL,
    REQUESTS_RECOVERY VARCHAR(1) NULL,
    PRIMARY KEY (ENTRY_ID)
)ENGINE=INNODB;

CREATE TABLE QRTZ_SCHEDULER_STATE
  (
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
    CHECKIN_INTERVAL BIGINT(13) NOT NULL,
    PRIMARY KEY (INSTANCE_NAME)
)ENGINE=INNODB;

CREATE TABLE QRTZ_LOCKS
  (
    LOCK_NAME  VARCHAR(40) NOT NULL, 
    PRIMARY KEY (LOCK_NAME)
)ENGINE=INNODB;

INSERT INTO QRTZ_LOCKS values('TRIGGER_ACCESS');

INSERT INTO QRTZ_LOCKS values('JOB_ACCESS');

INSERT INTO QRTZ_LOCKS values('CALENDAR_ACCESS');

INSERT INTO QRTZ_LOCKS values('STATE_ACCESS');

INSERT INTO QRTZ_LOCKS values('MISFIRE_ACCESS');

commit;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_2.5.0', 'hp', 'dbF360Mysql_2.5.0.xml', NOW(), 3, '8:e851da7646494a8c4902d85dd863f6a7', 'sql; sql; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_2.6.0.xml::f360Mysql_2.6.0::hp
ALTER TABLE agentcredential DROP credential;

ALTER TABLE consoleeventhandler MODIFY matchConditionsXml MEDIUMTEXT, MODIFY additionalMatchConditionsXml MEDIUMTEXT;

ALTER TABLE host ADD shouldHaveCert CHAR(1) DEFAULT 'N';

UPDATE host set shouldHaveCert=hasConnected;

ALTER TABLE hostlogmessage ADD connectionId VARCHAR(255);

ALTER TABLE issue ADD folder_id INT, MODIFY issueAbstract MEDIUMTEXT;

ALTER TABLE measurementhistory MODIFY measurementValue FLOAT(12,2);

ALTER TABLE measurementinstance MODIFY measurementValue FLOAT(12,2);

ALTER TABLE metadatarule MODIFY conditions MEDIUMTEXT;

ALTER TABLE payloadmessage MODIFY extraMessage MEDIUMTEXT;

ALTER TABLE projectversion MODIFY serverVersion FLOAT(8,2);

ALTER TABLE projectversion_rule MODIFY ruleGuid VARCHAR(255) NOT NULL;

ALTER TABLE projectversion_rule DROP PRIMARY KEY;

ALTER TABLE projectversion_rule ADD PRIMARY KEY (projectVersion_id, rule_id, ruleGuid);

ALTER TABLE rule_t ADD tips MEDIUMTEXT, ADD refers MEDIUMTEXT;

ALTER TABLE requirementtemplateinstance MODIFY serverVersion FLOAT(8,2);

ALTER TABLE runtimeevent ADD requestHost VARCHAR(255), ADD requestPort INT, ADD federationName VARCHAR(255)
, MODIFY severity FLOAT(8, 2), DROP accuracy, DROP impact,DROP likelihood, DROP probability;

ALTER TABLE applicationassignmentrule ADD searchSpec MEDIUMTEXT;

UPDATE applicationassignmentrule SET searchSpec = concat(concat('<?xml version="1.0" encoding="UTF-8" standalone="yes"?><ns2:SearchSpec pageSize="0" startIndex="0" xmlns:ns2="xmlns://www.fortifysoftware.com/schema/wsTypes" xmlns:ns4="xmlns://www.fortify.com/schema/issuemanagement" xmlns:ns3="http://www.fortify.com/schema/fws" xmlns:ns5="xmlns://www.fortifysoftware.com/schema/activitytemplate" xmlns:ns6="xmlns://www.fortify.com/schema/audit" xmlns:ns7="xmlns://www.fortifysoftware.com/schema/seed" xmlns:ns8="xmlns://www.fortifysoftware.com/schema/runtime"><ns2:SearchCondition xsi:type="ns2:ConjunctionFilterCondition" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><ns2:Condition xsi:type="ns2:ContainsSearchCondition"><ns2:SearchConstant>RE_REQUEST_PATH</ns2:SearchConstant><ns2:StringCondition>',context),'</ns2:StringCondition></ns2:Condition></ns2:SearchCondition></ns2:SearchSpec>')
WHERE context IS NOT NULL AND context <>'';

ALTER TABLE applicationassignmentrule DROP context;

ALTER TABLE scan MODIFY serverVersion FLOAT(8, 2);

ALTER TABLE scan_issue MODIFY accuracy FLOAT(8, 2), MODIFY likelihood FLOAT(8, 2), MODIFY impact FLOAT(8, 2), MODIFY probability FLOAT(8, 2), MODIFY issueAbstract MEDIUMTEXT;

ALTER TABLE rule_t MODIFY rawDetail MEDIUMTEXT, MODIFY rawRecommendation MEDIUMTEXT, MODIFY rawRuleAbstract MEDIUMTEXT
, MODIFY detail MEDIUMTEXT, MODIFY recommendation MEDIUMTEXT, MODIFY ruleAbstract MEDIUMTEXT;

ALTER TABLE runtimealert MODIFY eventHandlerDescription MEDIUMTEXT;

ALTER TABLE runtimeevent MODIFY requestHeader MEDIUMTEXT, MODIFY requestParameter MEDIUMTEXT, MODIFY cookie MEDIUMTEXT, MODIFY triggeredBy MEDIUMTEXT;

ALTER TABLE stacktrace MODIFY traceBody MEDIUMTEXT;

CREATE TABLE hostinfo(
    host_id      INT              NOT NULL,
    attrName     VARCHAR(255)     NOT NULL,
    attrValue    VARCHAR(1024),
    seqNumber    INT,
    PRIMARY KEY (host_id, attrName)
)ENGINE=INNODB;

ALTER TABLE hostinfo ADD CONSTRAINT RefHostInfo
    FOREIGN KEY (host_id)
    REFERENCES host(id)  ON DELETE CASCADE;

DROP VIEW ruleview;

CREATE VIEW ruleview AS
SELECT p.projectVersion_id projectVersion_id, r.id id,  r.guid descGuid, p.ruleGuid ruleGuid, r.rulepack_id rulepack_id, t.lang lang,
t.detail detail, t.recommendation recommendation, t.ruleAbstract ruleAbstract,
t.rawDetail rawDetail, t.rawRecommendation rawRecommendation, t.rawRuleAbstract rawRuleAbstract, t.tips tips, t.refers refers
FROM ruledescription r, rule_t t, projectversion_rule p
where r.id = t.id AND p.rule_id = r.id;

UPDATE agentcredential SET action= concat(action,'GetSingleUseFPRUploadTokenRequest') WHERE action LIKE '%FPRUploadRequest%';

update issue i, defaultissueview di set i.hidden= di.hidden, i.folder_id = di.folder_id where i.id = di.id;

UPDATE f360global SET schemaVersion='3.0.0';

update runtimeevent r set federationName=(select f.federationName from federation f,host h where h.federation_id=f.id and h.id=r.host_id);

DROP VIEW defaultissueview;

CREATE VIEW defaultissueview AS
select  i.folder_id, i.id, i.issueinstanceid,     i.fileName,     i.shortFileName,     i.severity,     i.ruleGuid,     i.confidence,     i.kingdom,     i.issueType,     i.issueSubtype,     i.analyzer,     i.lineNumber,     i.taintFlag,     i.packageName,     i.functionName,     i.className,     i.issueAbstract,     i.friority,     i.engineType,     i.scanStatus,     i.audienceSet,     i.lastScan_id,     i.replaceStore,     i.snippetId,     i.url,     i.category,     i.source,     i.sourceContext,     i.sourceFile,     i.sink,     i.sinkContext,     i.userName,     i.owasp2004,     i.owasp2007,     i.cwe,     i.revision,     i.audited,     i.auditedTime,     i.suppressed,     i.findingGuid,     i.issueStatus,     i.issueState,     i.dynamicConfidence,     i.remediationConstant,     i.projectVersion_id projectVersion_id,     i.hidden, i.likelihood, i.impact, i.accuracy,i.wasc,i.sans25, i.stig, i.pci11, i.pci12, i.rtaCovered, i.probability
from issue i;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_2.6.0', 'hp', 'dbF360Mysql_2.6.0.xml', NOW(), 5, '8:ae0a79c2933c161fa4aa1535a164ec56', 'sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_3.0.0.xml::f360Mysql_3.0.0::hp
ALTER TABLE activity              ADD dueDate INT;

ALTER TABLE activity              ADD dueDateUnits VARCHAR(20);

ALTER TABLE activityinstance      ADD dueDate DATETIME;

ALTER TABLE alert                 ADD startAtDueDate         CHAR(1)          DEFAULT 'N';

ALTER TABLE alerthistory          ADD alertStartAtDueDate    CHAR(1)          DEFAULT 'N';

ALTER TABLE artifact MODIFY documentInfo_id INT NULL;

ALTER TABLE artifact              ADD approvalComment VARCHAR(2000);

ALTER TABLE artifact              ADD approvalUsername VARCHAR(255);

ALTER TABLE artifact              ADD approvalDate DATETIME;

ALTER TABLE artifact              ADD job_id INT;

ALTER TABLE artifact              ADD associatedDocInfo_id INT;

ALTER TABLE artifact              ADD uploadDate DATETIME;

CREATE TABLE assessmentsite(
    id                      INT              NOT NULL,
    account_id              INT,
    siteId                  INT,
    siteUrl                 VARCHAR(2000),
    webApiKey               VARCHAR(255),
    currentScanStatus       VARCHAR(255),
    lastProjectVersionId    INT,
    lastJobSpecId           INT,
    registerDate            DATETIME,
    lastAssocDate           DATETIME,
    state                   VARCHAR(255),
    name                    VARCHAR(255),
    scheduleType            VARCHAR(255),
    scheduleTime            DATETIME,
    PRIMARY KEY (id)
)ENGINE=INNODB;

ALTER TABLE attr MODIFY extensible CHAR(1) DEFAULT 'N';

ALTER TABLE attr ADD restriction VARCHAR(20) DEFAULT 'NONE';

ALTER TABLE attrlookup ADD description VARCHAR(2000);

CREATE TABLE correlationresult(
    issue_id             INT              NOT NULL,
    correlation_id       INT              NOT NULL,
    checksum             VARCHAR(255)     NOT NULL,
    projectVersion_id    INT              NOT NULL,
    correlationValue     VARCHAR(2000)    NOT NULL,
    engineType           VARCHAR(255),
    PRIMARY KEY (issue_id, correlation_id, checksum)
)ENGINE=INNODB;

CREATE TABLE correlationrule(
    id                INT              AUTO_INCREMENT,
    name              VARCHAR(255),
    guid              VARCHAR(255),
    description       VARCHAR(2000),
    ruleXml           TEXT,
    objectVersion     INT,
    publishVersion    INT,
    ruleType          VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE correlationset(
    issue_id              INT             NOT NULL,
    projectVersion_id     INT             NOT NULL,
    correlationSetGuid    VARCHAR(255),
    PRIMARY KEY (issue_id)
)ENGINE=INNODB;

ALTER TABLE dynamicassessment     ADD siteId INT;

ALTER TABLE dynamicassessment     ADD uploadUserName VARCHAR(120);

ALTER TABLE issue MODIFY taintFlag VARCHAR(1024);

ALTER TABLE issue                 ADD foundDate              BIGINT;

ALTER TABLE issue                 ADD removedDate            BIGINT;

ALTER TABLE issue                 ADD requestIdentifier      LONGTEXT;

ALTER TABLE issue                 ADD requestHeader          LONGTEXT;

ALTER TABLE issue                 ADD requestParameter       LONGTEXT;

ALTER TABLE issue                 ADD requestBody            LONGTEXT;

ALTER TABLE issue                 ADD requestMethod          VARCHAR(20);

ALTER TABLE issue                 ADD cookie                 LONGTEXT;

ALTER TABLE issue                 ADD httpVersion            VARCHAR(20);

ALTER TABLE issue                 ADD attackPayload          LONGTEXT;

ALTER TABLE issue                 ADD attackType             VARCHAR(20);

ALTER TABLE issue                 ADD response               LONGTEXT;

ALTER TABLE issue                 ADD triggerDefinition      BLOB;

ALTER TABLE issue                 ADD triggerString          LONGTEXT;

ALTER TABLE issue                 ADD triggerDisplayText     LONGTEXT;

ALTER TABLE issue                 ADD secondaryRequest       LONGTEXT;

ALTER TABLE issue                 ADD sourceLine             FLOAT(8, 0);

ALTER TABLE issue                 ADD mappedCategory         VARCHAR(512);

ALTER TABLE issue                 ADD owasp2010              VARCHAR(120);

ALTER TABLE issue                 ADD fisma                  VARCHAR(120);

ALTER TABLE issue                 ADD sans2010               VARCHAR(120);

ALTER TABLE issue                 ADD issueRecommendation    LONGTEXT;

ALTER TABLE issue                 ADD correlated             CHAR(1)          DEFAULT 'N';

ALTER TABLE issue                 ADD correlationSetGuid     VARCHAR(255);

ALTER TABLE issue                 ADD tempInstanceId         VARCHAR(80);

ALTER TABLE issue                 ADD contextId              INT;

CREATE TABLE migrationhistory(
    serverVersion    FLOAT(8, 2)     NOT NULL,
    migrationTask    VARCHAR(255)    NOT NULL,
    PRIMARY KEY (serverVersion, migrationTask)
)ENGINE=INNODB;

ALTER TABLE payloadartifact       ADD uploadUserName         VARCHAR(120);

CREATE TABLE pref_page(
    id           INT              AUTO_INCREMENT,
    pref_id      INT              NOT NULL,
    seqNumber    INT,
    name         VARCHAR(4000),
    PRIMARY KEY (id)
)ENGINE=INNODB;

ALTER TABLE pref_pod              ADD page_id      INT;

ALTER TABLE pref_pod              ADD location     INT;

ALTER TABLE projecttemplate       ADD masterAttrGuid     VARCHAR(255);

ALTER TABLE projecttemplate       ADD defaultTemplate CHAR(1) DEFAULT 'N';

ALTER TABLE projectversion        ADD masterAttrGuid     VARCHAR(255);

CREATE TABLE projectversion_attr(
    projectVersion_id     INT             NOT NULL,
    attrGuid              VARCHAR(255)    NOT NULL,
    seqNumber             INT,
    PRIMARY KEY (projectVersion_id, attrGuid)
)ENGINE=INNODB;

INSERT INTO projectversion_attr(projectVersion_id, attrGuid, seqNumber)
(
SELECT pv.id, pta.attrGuid, pta.seqNumber
from projectversion pv INNER JOIN projecttemplate_attr pta on pta.projectTemplate_id = pv.projectTemplate_id
);

CREATE TABLE reportlibrary(
    id                 INT              AUTO_INCREMENT,
    name               VARCHAR(255)		NOT NULL,
    description        VARCHAR(2000),
    guid			   VARCHAR(255),
    fileDoc_id         INT              NOT NULL,
    objectVersion      INT,
    publishVersion     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

ALTER TABLE requirement           ADD dueDate INT;

ALTER TABLE requirement           ADD dueDateUnits VARCHAR(20);

ALTER TABLE requirementinstance   ADD dueDate DATETIME;

ALTER TABLE requirementtemplate   ADD dueDate INT;

ALTER TABLE requirementtemplate   ADD dueDateUnits VARCHAR(20);

ALTER TABLE requirementtemplateinstance   ADD dueDate DATETIME;

ALTER TABLE runtimeevent          ADD systemEventType           VARCHAR(20);

ALTER TABLE runtimeevent          ADD guid                      VARCHAR(120);

ALTER TABLE runtimeevent          ADD configurationEventGuid    VARCHAR(120);

ALTER TABLE runtimeevent          ADD rawEventLog               BLOB;

ALTER TABLE runtimeevent          ADD suggestedAction           VARCHAR(255);

ALTER TABLE runtimesetting MODIFY content TEXT;

ALTER TABLE scan                  ADD entryName              VARCHAR(255);

ALTER TABLE scan_issue MODIFY taintFlag VARCHAR(1024);

ALTER TABLE scan_issue            ADD issue_id               INT;

ALTER TABLE scan_issue            ADD requestIdentifier      LONGTEXT;

ALTER TABLE scan_issue            ADD requestHeader          LONGTEXT;

ALTER TABLE scan_issue            ADD requestParameter       LONGTEXT;

ALTER TABLE scan_issue            ADD requestBody            LONGTEXT;

ALTER TABLE scan_issue            ADD requestMethod          VARCHAR(20);

ALTER TABLE scan_issue            ADD httpVersion            VARCHAR(20);

ALTER TABLE scan_issue            ADD cookie                 LONGTEXT;

ALTER TABLE scan_issue            ADD attackPayload          LONGTEXT;

ALTER TABLE scan_issue            ADD attackType             VARCHAR(20);

ALTER TABLE scan_issue            ADD response               MEDIUMTEXT;

ALTER TABLE scan_issue            ADD triggerDefinition      BLOB;

ALTER TABLE scan_issue            ADD triggerString          LONGTEXT;

ALTER TABLE scan_issue            ADD triggerDisplayText     LONGTEXT;

ALTER TABLE scan_issue            ADD secondaryRequest       LONGTEXT;

ALTER TABLE scan_issue            ADD sourceLine             FLOAT(8, 0);

ALTER TABLE scan_issue            ADD mappedCategory         VARCHAR(512);

ALTER TABLE scan_issue            ADD owasp2010              VARCHAR(120);

ALTER TABLE scan_issue            ADD fisma                  VARCHAR(120);

ALTER TABLE scan_issue            ADD sans2010               VARCHAR(120);

ALTER TABLE scan_issue            ADD issueRecommendation    MEDIUMTEXT;

ALTER TABLE scan_issue            ADD contextId              INT;

ALTER TABLE taskinstance          ADD dueDate                DATETIME;

DROP VIEW auditvalueview;

CREATE VIEW auditvalueview AS
 SELECT a.projectVersion_id projectVersion_Id, a.issue_id issue_id, a.attrGuid attrGuid, a.attrValue lookupIndex, l.lookupValue lookupValue, attr.attrName attrName, attr.defaultValue, attr.hidden, l.seqNumber
 from auditvalue a, attr, attrlookup l
 where a.attrGuid=attr.guid and attr.id=l.attr_id and l.lookupIndex=a.attrValue;

DROP VIEW defaultissueview;

CREATE VIEW defaultissueview AS
select i.folder_id, i.id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence, i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName, i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet, i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink, i.sinkContext, i.userName, i.owasp2004, i.owasp2007, i.cwe, i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus, i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden, i.likelihood, i.impact, i.accuracy, i.wasc, i.sans25, i.stig, i.pci11, i.pci12, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader, i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition, i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion, i.cookie, i.mappedCategory, i.owasp2010, i.fisma, i.sans2010, i.correlated
from issue i;

CREATE OR REPLACE VIEW view_standards AS
 select i.folder_id, i.id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence, i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName, i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet, i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink, i.sinkContext, i.userName, i.owasp2004, i.owasp2007, i.cwe, i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus, i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden, i.likelihood, i.impact, i.accuracy, i.wasc, i.sans25 AS sans2009, i.stig, i.pci11, i.pci12, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader, i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition, i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion, i.cookie, i.mappedCategory, i.owasp2010, i.fisma AS fips200, i.sans2010, i.correlated
 from defaultissueview i
 where i.hidden='N' and i.suppressed='N' and i.scanStatus <> 'REMOVED' AND ((i.owasp2010 IS NOT NULL and upper(i.owasp2010) <> 'NONE') OR (i.fisma IS NOT NULL AND upper(i.fisma) <> 'NONE') OR (i.sans25 IS NOT NULL AND upper(i.sans25) <> 'NONE') OR (i.sans2010 IS NOT NULL AND upper(i.sans2010) <> 'NONE'));

CREATE UNIQUE INDEX assessmentsite_id_index ON assessmentsite(siteId);

CREATE INDEX correlationSetIndex ON correlationset(projectVersion_id, correlationSetGuid);

DROP INDEX Issue_Alt_Key ON issue;

CREATE UNIQUE INDEX Issue_Alt_Key ON issue(projectVersion_id, issueInstanceId, engineType);

CREATE INDEX tempInstanceId_Key ON issue(projectVersion_id, tempInstanceId);

CREATE UNIQUE INDEX RL_NAME_INDEX ON reportlibrary(name);

CREATE INDEX scanissueidkey ON scan_issue(issue_id, scan_id);

ALTER TABLE analysisblob DROP PRIMARY KEY;

ALTER TABLE correlationresult ADD CONSTRAINT Refprojectversion871
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE correlationset ADD CONSTRAINT Refprojectversion882
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE pref_page ADD CONSTRAINT ref_pref_page
    FOREIGN KEY (pref_id)
    REFERENCES userpreference(id);

ALTER TABLE projectversion_attr ADD CONSTRAINT RefPVPVAttr
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

DROP PROCEDURE updateExistingWithLatest;

DROP PROCEDURE updateDeletedIssues;

DROP PROCEDURE updateRemovedWithUpload;

DELIMITER //
CREATE PROCEDURE updateExistingWithLatest(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20))BEGIN
        UPDATE issue issue, scan_issue si SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet, issue.owasp2004=si.owasp2004, issue.owasp2007=si.owasp2007, issue.cwe=si.cwe
        , issue.scanStatus = (CASE WHEN scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.sans25=si.sans25, issue.wasc=si.wasc, issue.stig=si.stig, issue.pci11=si.pci11, issue.pci12=si.pci12, issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
		, issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
		, issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
		, issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory, issue.owasp2010=si.owasp2010, issue.fisma=si.fisma, issue.sans2010=si.sans2010
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id;

END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateDeletedIssues(p_scan_id INT,p_previous_scan_id INT, p_projectVersion_Id INT)BEGIN
        UPDATE issue issue, scan_issue si SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet, issue.owasp2004=si.owasp2004, issue.owasp2007=si.owasp2007, issue.cwe=si.cwe
        , issue.scanStatus = (CASE WHEN scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.sans25=si.sans25, issue.wasc=si.wasc, issue.stig=si.stig, issue.pci11=si.pci11, issue.pci12=si.pci12, issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
		, issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
		, issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
		, issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory, issue.owasp2010=si.owasp2010, issue.fisma=si.fisma, issue.sans2010=si.sans2010
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.lastScan_id= p_scan_id AND si.issue_id=issue.id AND si.scan_id= p_previous_scan_id;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateRemovedWithUpload(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20), p_scanDate BIGINT)BEGIN
        UPDATE issue issue, scan_issue si, scan scan SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet, issue.owasp2004=si.owasp2004, issue.owasp2007=si.owasp2007, issue.cwe=si.cwe
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.sans25=si.sans25, issue.wasc=si.wasc, issue.stig=si.stig, issue.pci11=si.pci11, issue.pci12=si.pci12, issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
		, issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
		, issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
		, issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory, issue.owasp2010=si.owasp2010, issue.fisma=si.fisma, issue.sans2010=si.sans2010
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id AND issue.scanStatus='REMOVED' AND
        issue.lastScan_id = scan.id and scan.startDate < p_scanDate;

END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateScanIssueIds(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20))BEGIN
        UPDATE scan_issue si, issue issue SET si.issue_id=issue.id
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType
        AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id;

END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE migrateScanIssueIds(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20))BEGIN
        UPDATE scan_issue si, issue issue SET si.issue_id=issue.id
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType
        AND si.issueInstanceId=issue.tempInstanceId AND si.scan_id= p_scan_id;

END//
DELIMITER ;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_3.0.0', 'hp', 'dbF360Mysql_3.0.0.xml', NOW(), 7, '8:11ea4ac162783b1fbd5f872f3cf439bb', 'sql; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_3.1.0.xml::f360Mysql_3.1.0::hp
ALTER TABLE runtimeapplication ADD eventState VARCHAR(20);

UPDATE runtimeapplication SET eventState = 'UPDATED';

DROP INDEX RE_DATE ON runtimeevent;

CREATE INDEX RE_RA ON runtimeevent(runtimeApplication_id);

ALTER TABLE sourcefilemap MODIFY crossRef LONGBLOB;

ALTER TABLE projectversion ADD tracesOutOfDate CHAR(1) DEFAULT 'N';

UPDATE projectversion SET tracesOutOfDate = 'Y';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_3.1.0', 'hp', 'dbF360Mysql_3.1.0.xml', NOW(), 9, '8:fbe765f8d0292a4abe6fbc8365ec84f7', 'sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.2.0.xml::f360_3.2.0_0::hp
ALTER TABLE permission ADD userOnly CHAR(1) NULL;

ALTER TABLE permissiontemplate DROP COLUMN sortOrder;

ALTER TABLE permissiontemplate DROP COLUMN userOnly;

ALTER TABLE permissiontemplate ADD guid VARCHAR(255) NULL, ADD `description` VARCHAR(2000) NULL, ADD allApplicationRole CHAR(1) DEFAULT 'N' NULL, ADD objectVersion INT NULL, ADD publishVersion INT NULL;

UPDATE permissiontemplate SET guid = 'admin', name = 'Administrator' WHERE name='admin';

UPDATE permissiontemplate SET guid = 'securitylead', name = 'Security Lead' WHERE name='securitylead';

UPDATE permissiontemplate SET guid = 'manager', name = 'Manager' WHERE name='manager';

UPDATE permissiontemplate SET guid = 'developer', name = 'Developer' WHERE name='developer';

UPDATE permissiontemplate SET objectVersion = 1, publishVersion = 1;

ALTER TABLE projectversion ADD obfuscatedId VARCHAR(255) NULL;

ALTER TABLE projectversion ADD businessAttrOutstanding CHAR(1) NULL;

ALTER TABLE projectversion ADD technicalAttrOutstanding CHAR(1) NULL;

ALTER TABLE projectversion ADD creationState VARCHAR(64) NULL;

UPDATE projectversion SET businessAttrOutstanding = 'N', technicalAttrOutstanding = 'N';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.2.0_0', 'hp', 'dbF360_3.2.0.xml', NOW(), 11, '8:9a80b24f7567b12371ec15b258218ead', 'addColumn tableName=permission; dropColumn columnName=sortOrder, tableName=permissiontemplate; dropColumn columnName=userOnly, tableName=permissiontemplate; addColumn tableName=permissiontemplate; update tableName=permissiontemplate; update tableN...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.2.0.xml::f360_3.2.0_1::hp
CREATE TABLE permissiongroup (id INT AUTO_INCREMENT NOT NULL, guid VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, `description` VARCHAR(2000) NULL, assignByDefault CHAR(1) DEFAULT 'N' NULL, objectVersion INT NULL, publishVersion INT NULL, CONSTRAINT PK_PERMISSIONGROUP PRIMARY KEY (id)) engine innodb;

CREATE TABLE pg_permission (pg_id INT NOT NULL, permission_id INT NOT NULL, CONSTRAINT PK_PG_PERMISSION PRIMARY KEY (pg_id, permission_id)) engine innodb;

CREATE TABLE pt_pg (pt_id INT NOT NULL, pg_id INT NOT NULL, CONSTRAINT PK_PT_PG PRIMARY KEY (pt_id, pg_id)) engine innodb;

CREATE TABLE permissiongroup_dependants (permissionGroup_id INT NOT NULL, dependsOn_id INT NOT NULL, CONSTRAINT PK_PERMISSIONGROUP_DEPENDANTS PRIMARY KEY (permissionGroup_id, dependsOn_id)) engine innodb;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.2.0_1', 'hp', 'dbF360_3.2.0.xml', NOW(), 13, '8:161e4d168c35332676358321ecb324e2', 'createTable tableName=permissiongroup; createTable tableName=pg_permission; createTable tableName=pt_pg; createTable tableName=permissiongroup_dependants', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.2.0.xml::f360_3.2.0_2::hp
CREATE UNIQUE INDEX pt_guid_idx ON permissiontemplate(guid);

CREATE UNIQUE INDEX pg_guid_idx ON permissiongroup(guid);

CREATE UNIQUE INDEX pg_name_idx ON permissiongroup(name);

ALTER TABLE pg_permission ADD CONSTRAINT RefPGPerPG FOREIGN KEY (pg_id) REFERENCES permissiongroup (id) ON DELETE CASCADE;

ALTER TABLE pg_permission ADD CONSTRAINT RefPGPerPer FOREIGN KEY (permission_id) REFERENCES permission (id) ON DELETE CASCADE;

ALTER TABLE pt_pg ADD CONSTRAINT RefPTPG_PT FOREIGN KEY (pt_id) REFERENCES permissiontemplate (id) ON DELETE CASCADE;

ALTER TABLE pt_pg ADD CONSTRAINT RefPTPG_PG FOREIGN KEY (pg_id) REFERENCES permissiongroup (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.2.0_2', 'hp', 'dbF360_3.2.0.xml', NOW(), 15, '8:d2171d8f465081430a1d97c4002c991a', 'createIndex indexName=pt_guid_idx, tableName=permissiontemplate; createIndex indexName=pg_guid_idx, tableName=permissiongroup; createIndex indexName=pg_name_idx, tableName=permissiongroup; addForeignKeyConstraint baseTableName=pg_permission, const...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.4.0.xml::f360_3.4.0_0::hp
CREATE TABLE bugtrackerconfig (id INT AUTO_INCREMENT NOT NULL, identifier VARCHAR(255) NOT NULL, value VARCHAR(255) NULL, projectVersionId INT NOT NULL, CONSTRAINT PK_BUGTRACKERCONFIG PRIMARY KEY (id)) engine innodb;

CREATE TABLE bug (id INT AUTO_INCREMENT NOT NULL, externalBugId VARCHAR(255) NOT NULL, CONSTRAINT PK_BUG PRIMARY KEY (id)) engine innodb;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.4.0_0', 'hp', 'dbF360_3.4.0.xml', NOW(), 17, '8:d8d2d902d4a1d4e34c869bfcd6d24a11', 'createTable tableName=bugtrackerconfig; createTable tableName=bug', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.4.0.xml::f360_3.4.0_1::hp
ALTER TABLE projectversion ADD bugTrackerPluginId VARCHAR(255) NULL;

ALTER TABLE issue ADD bug_id INT NULL;

ALTER TABLE bugtrackerconfig ADD CONSTRAINT fk_bugtc_projectversion FOREIGN KEY (projectVersionId) REFERENCES projectversion (id);

ALTER TABLE issue ADD CONSTRAINT fk_issue_bug FOREIGN KEY (bug_id) REFERENCES bug (id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.4.0_1', 'hp', 'dbF360_3.4.0.xml', NOW(), 19, '8:7e1d9a8c1324d52096469ba052068c40', 'addColumn tableName=projectversion; addColumn tableName=issue; addForeignKeyConstraint baseTableName=bugtrackerconfig, constraintName=fk_bugtc_projectversion, referencedTableName=projectversion; addForeignKeyConstraint baseTableName=issue, constra...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.4.0.xml::f360_3.4.0_2::hp
ALTER TABLE issue ADD pci20 VARCHAR(120) NULL;

ALTER TABLE scan_issue ADD pci20 VARCHAR(120) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.4.0_2', 'hp', 'dbF360_3.4.0.xml', NOW(), 21, '8:32b29529e52b93eae4babbc648ea1c5a', 'addColumn tableName=issue; addColumn tableName=scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.4.0.xml::f360_3.4.0_3::hp
ALTER TABLE issue ADD attackTriggerDefinition MEDIUMBLOB NULL, ADD vulnerableParameter VARCHAR(100) NULL, ADD reproStepDefinition MEDIUMBLOB NULL, ADD stackTrace MEDIUMTEXT NULL, ADD stackTraceTriggerDisplayText VARCHAR(255) NULL;

ALTER TABLE scan_issue ADD attackTriggerDefinition MEDIUMBLOB NULL, ADD vulnerableParameter VARCHAR(100) NULL, ADD reproStepDefinition MEDIUMBLOB NULL, ADD stackTrace MEDIUMTEXT NULL, ADD stackTraceTriggerDisplayText VARCHAR(255) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.4.0_3', 'hp', 'dbF360_3.4.0.xml', NOW(), 23, '8:bc4c199c19ae5c21f27f2fd2da43835e', 'addColumn tableName=issue; addColumn tableName=scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.4.0.xml::f360_3.4.0_4::hp
CREATE TABLE auditattachment (id INT AUTO_INCREMENT NOT NULL, guid VARCHAR(255) NOT NULL, issue_id INT NOT NULL, documentInfo_id INT NOT NULL, attachmentType VARCHAR(40) NOT NULL, `description` VARCHAR(2000) NULL, CONSTRAINT PK_AUDITATTACHMENT PRIMARY KEY (id)) engine innodb;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.4.0_4', 'hp', 'dbF360_3.4.0.xml', NOW(), 25, '8:79da95ee7f120e60dfbcb9d81cbfa7f9', 'createTable tableName=auditattachment', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.4.0.xml::f360_3.4.0_5::hp
ALTER TABLE auditattachment ADD CONSTRAINT RefIssueAuditAttach FOREIGN KEY (issue_id) REFERENCES issue (id) ON DELETE CASCADE;

ALTER TABLE auditattachment ADD CONSTRAINT RefDocInfoAuditAttach FOREIGN KEY (documentInfo_id) REFERENCES documentinfo (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.4.0_5', 'hp', 'dbF360_3.4.0.xml', NOW(), 27, '8:5b899a1bf3949c07349daa167ef29dd7', 'addForeignKeyConstraint baseTableName=auditattachment, constraintName=RefIssueAuditAttach, referencedTableName=issue; addForeignKeyConstraint baseTableName=auditattachment, constraintName=RefDocInfoAuditAttach, referencedTableName=documentinfo', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.4.0.xml::f360_3.4.0_6::hp
ALTER TABLE projectversion ADD attachmentsOutOfDate CHAR(1) DEFAULT 'N' NULL;

UPDATE projectversion SET attachmentsOutOfDate = 'N';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.4.0_6', 'hp', 'dbF360_3.4.0.xml', NOW(), 29, '8:2c86b7fecf3901d3b4030821aabfbbbc', 'addColumn tableName=projectversion; update tableName=projectversion', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.4.0.xml::f360_3.4.0_8::hp
ALTER TABLE agentcredential ADD tempContent MEDIUMTEXT NULL;

UPDATE agentcredential SET tempContent = action;

ALTER TABLE agentcredential DROP COLUMN action;

ALTER TABLE agentcredential ADD action MEDIUMTEXT NULL;

UPDATE agentcredential SET action = tempContent;

ALTER TABLE agentcredential DROP COLUMN tempContent;

ALTER TABLE artifact ADD tempMessages MEDIUMTEXT NULL;

UPDATE artifact SET tempMessages = messages;

ALTER TABLE artifact DROP COLUMN messages;

ALTER TABLE artifact ADD messages MEDIUMTEXT NULL;

UPDATE artifact SET messages = tempMessages;

ALTER TABLE artifact DROP COLUMN tempMessages;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.4.0_8', 'hp', 'dbF360_3.4.0.xml', NOW(), 31, '8:709d42fab1d6d7b59e9e4940afa225bb', 'addColumn tableName=agentcredential; update tableName=agentcredential; dropColumn columnName=action, tableName=agentcredential; addColumn tableName=agentcredential; update tableName=agentcredential; dropColumn columnName=tempContent, tableName=age...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.5.0.xml::f360_3.5.0_0::hp
ALTER TABLE bugtrackerconfig ADD tempProjectVersionId INT NULL;

UPDATE bugtrackerconfig SET tempProjectVersionId = projectVersionId;

ALTER TABLE bugtrackerconfig DROP FOREIGN KEY fk_bugtc_projectversion;

ALTER TABLE bugtrackerconfig DROP COLUMN projectVersionId;

ALTER TABLE bugtrackerconfig ADD projectVersion_Id INT DEFAULT 1 NOT NULL;

UPDATE bugtrackerconfig SET projectVersion_Id = tempProjectVersionId;

ALTER TABLE bugtrackerconfig DROP COLUMN tempProjectVersionId;

ALTER TABLE bugtrackerconfig ADD CONSTRAINT fk_bugtc_projectversion FOREIGN KEY (projectVersion_Id) REFERENCES projectversion (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.5.0_0', 'hp', 'dbF360_3.5.0.xml', NOW(), 33, '8:cc9def59aa44d7c8c445638da50ad0dc', 'addColumn tableName=bugtrackerconfig; update tableName=bugtrackerconfig; dropForeignKeyConstraint baseTableName=bugtrackerconfig, constraintName=fk_bugtc_projectversion; dropColumn columnName=projectVersionId, tableName=bugtrackerconfig; addColumn...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.5.0.xml::f360_3.5.0_2::hp
CREATE TABLE projectversioncreation (projectVersion_id INT NOT NULL, previousProjectVersion_id INT NULL, copyAnalysisProcessingRules CHAR(1) DEFAULT 'N' NULL, copyBugTrackerConfiguration CHAR(1) DEFAULT 'N' NULL, copyCurrentStateFpr CHAR(1) DEFAULT 'N' NULL, copyCustomTags CHAR(1) DEFAULT 'N' NULL, copyProjectVersionAttributes CHAR(1) DEFAULT 'N' NULL, copyUserAssignment CHAR(1) DEFAULT 'N' NULL, CONSTRAINT PK_PROJECTVERSIONCREATION PRIMARY KEY (projectVersion_id)) engine innodb;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.5.0_2', 'hp', 'dbF360_3.5.0.xml', NOW(), 35, '8:8719e76750bb4f8568aa6777b5b94cf6', 'createTable tableName=projectversioncreation', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.5.0.xml::f360_3.5.0_3::hp
ALTER TABLE projectversioncreation ADD CONSTRAINT fk_pvcreate_projectversion FOREIGN KEY (projectVersion_id) REFERENCES projectversion (id);

ALTER TABLE projectversioncreation ADD CONSTRAINT fk_oldpvcreate_projectversion FOREIGN KEY (previousProjectVersion_id) REFERENCES projectversion (id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.5.0_3', 'hp', 'dbF360_3.5.0.xml', NOW(), 37, '8:fa7ec73ee046b5a8d2de600addccd36e', 'addForeignKeyConstraint baseTableName=projectversioncreation, constraintName=fk_pvcreate_projectversion, referencedTableName=projectversion; addForeignKeyConstraint baseTableName=projectversioncreation, constraintName=fk_oldpvcreate_projectversion...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.5.0.xml::f360_3.5.0_4::hp
ALTER TABLE projectversion ADD projectTemplateModifiedTime BIGINT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.5.0_4', 'hp', 'dbF360_3.5.0.xml', NOW(), 39, '8:548a8cd67f6d000b1269dcc49b6c27fd', 'addColumn tableName=projectversion', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.5.0.xml::f360_3.5.0_5::hp
ALTER TABLE issue MODIFY shortFileName VARCHAR(500);

ALTER TABLE scan_issue MODIFY shortFileName VARCHAR(500);

ALTER TABLE issue MODIFY sink VARCHAR(2000);

ALTER TABLE scan_issue MODIFY sink VARCHAR(2000);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.5.0_5', 'hp', 'dbF360_3.5.0.xml', NOW(), 41, '8:f2229174ebf174dd07fbe7bd283f75ad', 'modifyDataType columnName=shortFileName, tableName=issue; modifyDataType columnName=shortFileName, tableName=scan_issue; modifyDataType columnName=sink, tableName=issue; modifyDataType columnName=sink, tableName=scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.5.0.xml::f360_3.5.0_6::hp
ALTER TABLE issue DROP FOREIGN KEY fk_issue_bug;

ALTER TABLE issue ADD CONSTRAINT fk_issue_bug FOREIGN KEY (bug_id) REFERENCES bug (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.5.0_6', 'hp', 'dbF360_3.5.0.xml', NOW(), 43, '8:9bafc3ba8f52263de85c7216a2754230', 'dropForeignKeyConstraint baseTableName=issue, constraintName=fk_issue_bug; addForeignKeyConstraint baseTableName=issue, constraintName=fk_issue_bug, referencedTableName=bug', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.51.0.xml::f360_3.51.0_0::hp
ALTER TABLE metavalue ADD dateValue date NULL;

ALTER TABLE metavalue ADD integerValue BIGINT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.51.0_0', 'hp', 'dbF360_3.51.0.xml', NOW(), 45, '8:3f146ffe11c75fdee6e0531db1abac50', 'addColumn tableName=metavalue; addColumn tableName=metavalue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_0::hp
DROP VIEW view_standards;

DROP VIEW defaultissueview;

ALTER TABLE issue DROP COLUMN cwe;

ALTER TABLE issue DROP COLUMN fisma;

ALTER TABLE issue DROP COLUMN owasp2004;

ALTER TABLE issue DROP COLUMN owasp2007;

ALTER TABLE issue DROP COLUMN owasp2010;

ALTER TABLE issue DROP COLUMN pci11;

ALTER TABLE issue DROP COLUMN pci12;

ALTER TABLE issue DROP COLUMN pci20;

ALTER TABLE issue DROP COLUMN sans2010;

ALTER TABLE issue DROP COLUMN sans25;

ALTER TABLE issue DROP COLUMN stig;

ALTER TABLE issue DROP COLUMN wasc;

ALTER TABLE scan_issue DROP COLUMN cwe;

ALTER TABLE scan_issue DROP COLUMN fisma;

ALTER TABLE scan_issue DROP COLUMN owasp2004;

ALTER TABLE scan_issue DROP COLUMN owasp2007;

ALTER TABLE scan_issue DROP COLUMN owasp2010;

ALTER TABLE scan_issue DROP COLUMN pci11;

ALTER TABLE scan_issue DROP COLUMN pci12;

ALTER TABLE scan_issue DROP COLUMN pci20;

ALTER TABLE scan_issue DROP COLUMN sans2010;

ALTER TABLE scan_issue DROP COLUMN sans25;

ALTER TABLE scan_issue DROP COLUMN stig;

ALTER TABLE scan_issue DROP COLUMN wasc;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_0', 'hp', 'dbF360_3.6.0.xml', NOW(), 47, '8:df33326371f06b10a1db6531bf759a0d', 'dropView viewName=view_standards; dropView viewName=defaultissueview; dropColumn columnName=cwe, tableName=issue; dropColumn columnName=fisma, tableName=issue; dropColumn columnName=owasp2004, tableName=issue; dropColumn columnName=owasp2007, tabl...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_1::hp
CREATE TABLE catpackexternallist (id INT AUTO_INCREMENT NOT NULL, guid VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, `description` VARCHAR(2000) NULL, groupName VARCHAR(255) NULL, orderingInfo INT NULL, CONSTRAINT PK_CATPACKEXTERNALLIST PRIMARY KEY (id), UNIQUE (guid)) engine innodb;

CREATE TABLE catpackshortcut (id INT AUTO_INCREMENT NOT NULL, catPackExternalList_id INT NOT NULL, name VARCHAR(255) NOT NULL, CONSTRAINT PK_CATPACKSHORTCUT PRIMARY KEY (id)) engine innodb;

CREATE TABLE catpackexternalcategory (id INT AUTO_INCREMENT NOT NULL, catPackExternalList_id INT NOT NULL, name VARCHAR(255) NOT NULL, `description` VARCHAR(2000) NULL, orderingInfo INT NULL, CONSTRAINT PK_CATPACKEXTERNALCATEGORY PRIMARY KEY (id)) engine innodb;

CREATE TABLE catpacklookup (catPackExternalCategory_id INT NOT NULL, mappedCategory VARCHAR(255) NOT NULL, orderingInfo INT NULL, fromExtension CHAR(1) DEFAULT 'N' NULL, CONSTRAINT PK_CATPACKLOOKUP PRIMARY KEY (catPackExternalCategory_id, mappedCategory)) engine innodb;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_1', 'hp', 'dbF360_3.6.0.xml', NOW(), 49, '8:f48ef8f0a6639d4c971811f3245a437e', 'createTable tableName=catpackexternallist; createTable tableName=catpackshortcut; createTable tableName=catpackexternalcategory; createTable tableName=catpacklookup', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_2::hp
CREATE UNIQUE INDEX catPackExtListName_idx ON catpackexternallist(name);

CREATE UNIQUE INDEX catPackExtCatNameExtListId_idx ON catpackexternalcategory(catPackExternalList_id, name);

ALTER TABLE catpackexternalcategory ADD CONSTRAINT catPackExtCatExtListId_FK FOREIGN KEY (catPackExternalList_id) REFERENCES catpackexternallist (id) ON DELETE CASCADE;

CREATE UNIQUE INDEX catPackShortcutName_idx ON catpackshortcut(name);

ALTER TABLE catpackshortcut ADD CONSTRAINT catPackShortcutExtListId_FK FOREIGN KEY (catPackExternalList_id) REFERENCES catpackexternallist (id) ON DELETE CASCADE;

CREATE INDEX catPackLookupMapCat_idx ON catpacklookup(mappedCategory);

CREATE INDEX catPackLookupExtCatId_idx ON catpacklookup(catPackExternalCategory_id);

ALTER TABLE catpacklookup ADD CONSTRAINT catPackLookupAltCatId_FK FOREIGN KEY (catPackExternalCategory_id) REFERENCES catpackexternalcategory (id) ON DELETE CASCADE;

CREATE VIEW baseIssueView AS SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence,
			i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName,
			i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet,
			i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink,
			i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus,
			i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden,
			i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader,
			i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition,
			i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion,
			i.cookie, i.mappedCategory, i.correlated
			FROM issue i;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_2', 'hp', 'dbF360_3.6.0.xml', NOW(), 51, '8:ae8fdc407bc269362eb032f0d4d12225', 'createIndex indexName=catPackExtListName_idx, tableName=catpackexternallist; createIndex indexName=catPackExtCatNameExtListId_idx, tableName=catpackexternalcategory; addForeignKeyConstraint baseTableName=catpackexternalcategory, constraintName=cat...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_3.6.0.xml::f360Mysql_3.6.0_0::hp
ALTER TABLE analysisblob ADD PRIMARY KEY (projectVersion_id, engineType, issueInstanceId);

DELIMITER //
CREATE FUNCTION getExternalCategories(mc VARCHAR(255), externalListName VARCHAR(255))RETURNS VARCHAR(1024) NOT DETERMINISTIC
READS SQL DATA
RETURN (SELECT group_concat(CASE ecl.fromExtension WHEN 'Y' THEN ec.name || '*' ELSE ec.name END ORDER BY ec.orderingInfo, ', ')
  FROM catpacklookup ecl, catpackexternalcategory ec
  WHERE ecl.catpackexternalcategory_id=ec.id
  AND ec.catpackexternallist_id=(SELECT id FROM catpackexternallist WHERE name=externalListName)
  AND ecl.mappedCategory = mc
  GROUP BY ecl.mappedCategory)//
DELIMITER ;

CREATE OR REPLACE VIEW defaultissueview AS
SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence, i.kingdom, i.issueType, i.issueSubtype, i.analyzer,
i.lineNumber, i.taintFlag, i.packageName, i.functionName, i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, 
i.audienceSet, i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink, i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus, i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden, i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader, i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition, i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion, i.cookie, i.mappedCategory, i.correlated,
i.attackTriggerDefinition, i.vulnerableParameter, i.reproStepDefinition, i.stackTrace, i.stackTraceTriggerDisplayText, i.bug_id,
getExternalCategories(i.mappedCategory, 'OWASP Top 10 2004') AS owasp2004,
getExternalCategories(i.mappedCategory, 'OWASP Top 10 2007') AS owasp2007,
getExternalCategories(i.mappedCategory, 'OWASP Top 10 2010') AS owasp2010,
getExternalCategories(i.mappedCategory, 'CWE') AS cwe,
getExternalCategories(i.mappedCategory, 'SANS Top 25 2009') AS sans25,
getExternalCategories(i.mappedCategory, 'SANS Top 25 2010') AS sans2010,
getExternalCategories(i.mappedCategory, 'WASC 24 + 2') AS wasc,
getExternalCategories(i.mappedCategory, 'STIG 3') AS stig,
getExternalCategories(i.mappedCategory, 'PCI 1.1') AS pci11,
getExternalCategories(i.mappedCategory, 'PCI 1.2') AS pci12,
getExternalCategories(i.mappedCategory, 'PCI 2.0') AS pci20,
getExternalCategories(i.mappedCategory, 'FISMA') AS fisma
FROM issue i;

DROP PROCEDURE updateExistingWithLatest;

DROP PROCEDURE updateDeletedIssues;

DROP PROCEDURE updateRemovedWithUpload;

DELIMITER //
CREATE PROCEDURE updateExistingWithLatest(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20))BEGIN
        UPDATE issue issue, scan_issue si SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.scanStatus = (CASE WHEN scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
		, issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
		, issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
		, issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id;

END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateDeletedIssues(p_scan_id INT,p_previous_scan_id INT, p_projectVersion_Id INT)BEGIN
        UPDATE issue issue, scan_issue si SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.scanStatus = (CASE WHEN scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
		, issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
		, issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
		, issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.lastScan_id= p_scan_id AND si.issue_id=issue.id AND si.scan_id= p_previous_scan_id;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateRemovedWithUpload(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20), p_scanDate BIGINT)BEGIN
        UPDATE issue issue, scan_issue si, scan scan SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
		, issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
		, issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
		, issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id AND issue.scanStatus='REMOVED' AND
        issue.lastScan_id = scan.id and scan.startDate < p_scanDate;

END//
DELIMITER ;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_3.6.0_0', 'hp', 'dbF360Mysql_3.6.0.xml', NOW(), 53, '8:f9f5cc5597936a1251b5a609a63ddf43', 'addPrimaryKey constraintName=pk_analysisblob, tableName=analysisblob; sql; sql; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_3.6.0.xml::f360Mysql_3.6.0_1::hp
--  Solves index creation issues for MySQL utf8_bin collation
ALTER TABLE `issue` ROW_FORMAT=DYNAMIC;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_3.6.0_1', 'hp', 'dbF360Mysql_3.6.0.xml', NOW(), 55, '8:e2342f33117bdc67103c4f2f106d336f', 'sql', 'Solves index creation issues for MySQL utf8_bin collation', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_4::hp
CREATE VIEW view_standards AS SELECT i.folder_id, i.id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence, i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName, i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet, i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink, i.sinkContext, i.userName, i.owasp2004, i.owasp2007, i.cwe, i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus, i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id, i.hidden, i.likelihood, i.impact, i.accuracy, i.wasc, i.sans25 AS sans2009, i.stig, i.pci11, i.pci12, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader, i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.attackTriggerDefinition, i.response, i.triggerDefinition, i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion, i.cookie, i.mappedCategory, i.owasp2010, i.fisma AS fips200, i.sans2010, i.correlated, i.pci20, i.vulnerableParameter, i.reproStepDefinition, i.stackTrace, i.stackTraceTriggerDisplayText
			from defaultissueview i
			where i.hidden='N' and i.suppressed='N' and i.scanStatus <> 'REMOVED' AND ((i.owasp2010 IS NOT NULL and upper(i.owasp2010) <> 'NONE') OR (i.fisma IS NOT NULL AND upper(i.fisma) <> 'NONE') OR (i.sans25 IS NOT NULL AND upper(i.sans25) <> 'NONE') OR (i.sans2010 IS NOT NULL AND upper(i.sans2010) <> 'NONE') OR (i.pci20 IS NOT NULL AND upper(i.pci20) <> 'NONE'));

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_4', 'hp', 'dbF360_3.6.0.xml', NOW(), 57, '8:5fd91bd700da30a411fb22dc1b158eb7', 'createView viewName=view_standards', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_5::hp
UPDATE issue SET mappedCategory = category WHERE mappedCategory is null;

UPDATE scan_issue SET mappedCategory = category WHERE mappedCategory is null;

CREATE INDEX issue_mappedCategory_idx ON issue(projectVersion_id, mappedCategory);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_5', 'hp', 'dbF360_3.6.0.xml', NOW(), 59, '8:9aaabd367ba6e53bfa89c26d82482256', 'update tableName=issue; update tableName=scan_issue; createIndex indexName=issue_mappedCategory_idx, tableName=issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_6::hp
ALTER TABLE issuecache ADD CONSTRAINT fk_issuecache_issue FOREIGN KEY (issue_id) REFERENCES issue (id) ON DELETE CASCADE;

CREATE INDEX analysisblob_pvid_iid ON analysisblob(projectVersion_id, issueInstanceId);

CREATE INDEX issue_summary_idx ON issue(projectVersion_id, suppressed, hidden, scanStatus, friority, engineType);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_6', 'hp', 'dbF360_3.6.0.xml', NOW(), 61, '8:1a81ebc4a47dd940ea033f0f638ca3fe', 'addForeignKeyConstraint baseTableName=issuecache, constraintName=fk_issuecache_issue, referencedTableName=issue; createIndex indexName=analysisblob_pvid_iid, tableName=analysisblob; createIndex indexName=issue_summary_idx, tableName=issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_7::hp
ALTER TABLE issuecache DROP COLUMN issueInstanceId;

DROP INDEX viewIssueIndex ON issuecache;

DROP INDEX IssueCacheAltKey ON issuecache;

ALTER TABLE issuecache MODIFY projectVersion_id INT NOT NULL;

ALTER TABLE issuecache MODIFY folder_id INT NOT NULL;

ALTER TABLE issuecache MODIFY hidden CHAR(1) NOT NULL;

ALTER TABLE issuecache DROP PRIMARY KEY;

ALTER TABLE issuecache ADD PRIMARY KEY (projectVersion_id, filterSet_id, issue_id, hidden, folder_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_7', 'hp', 'dbF360_3.6.0.xml', NOW(), 63, '8:efcbb99f7a76624dc2ab0da22c41f1a4', 'dropColumn columnName=issueInstanceId, tableName=issuecache; dropIndex indexName=viewIssueIndex, tableName=issuecache; dropIndex indexName=IssueCacheAltKey, tableName=issuecache; addNotNullConstraint columnName=projectVersion_id, tableName=issueca...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_8::hp
ALTER TABLE variable ADD folderName VARCHAR(80) DEFAULT 'All' NOT NULL;

CREATE TABLE projecttemplatefolder (projectTemplate_id INT NOT NULL, folderName VARCHAR(80) NOT NULL, CONSTRAINT PK_PROJECTTEMPLATEFOLDER PRIMARY KEY (projectTemplate_id, folderName));

ALTER TABLE projecttemplatefolder ADD CONSTRAINT fk_ptf_projecttemplate FOREIGN KEY (projectTemplate_id) REFERENCES projecttemplate (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_8', 'hp', 'dbF360_3.6.0.xml', NOW(), 65, '8:539d467ccf958a51b798777592275562', 'addColumn tableName=variable; createTable tableName=projecttemplatefolder; addForeignKeyConstraint baseTableName=projecttemplatefolder, constraintName=fk_ptf_projecttemplate, referencedTableName=projecttemplate', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_9::hp
ALTER TABLE projectversion ADD siteId VARCHAR(255) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_9', 'hp', 'dbF360_3.6.0.xml', NOW(), 67, '8:d1fb2994b4c6e628baf4042ec9af7efa', 'addColumn tableName=projectversion', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_10::hp
ALTER TABLE auditattachment ADD updateTime datetime NULL, ADD deleted CHAR(1) DEFAULT 'N' NULL;

UPDATE auditattachment SET deleted = 'N' WHERE deleted IS NULL;

ALTER TABLE auditattachment MODIFY deleted CHAR(1) NOT NULL;

UPDATE auditattachment SET updateTime = (select d.uploadDate from documentinfo d where documentInfo_id = d.id);

ALTER TABLE auditattachment MODIFY updateTime datetime NOT NULL;

ALTER TABLE auditattachment MODIFY documentInfo_id INT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_10', 'hp', 'dbF360_3.6.0.xml', NOW(), 69, '8:75f693cb5560d07e1945eca0927abfad', 'addColumn tableName=auditattachment; addNotNullConstraint columnName=deleted, tableName=auditattachment; update tableName=auditattachment; addNotNullConstraint columnName=updateTime, tableName=auditattachment; dropNotNullConstraint columnName=docu...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.11.1::hp
ALTER TABLE report_projectversion DROP FOREIGN KEY RefSavedRepPV;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.11.1', 'hp', 'dbF360_3.6.0.xml', NOW(), 71, '8:08efbfe474b89e39de76f8e3041caea3', 'dropForeignKeyConstraint baseTableName=report_projectversion, constraintName=RefSavedRepPV', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_12_fix::hp
INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_12_fix', 'hp', 'dbF360_3.6.0.xml', NOW(), 73, '8:32929a42801d14362dd224e49765b582', 'delete tableName=report_projectversion', '', 'MARK_RAN', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_12::hp
ALTER TABLE report_projectversion DROP PRIMARY KEY;

ALTER TABLE report_projectversion ADD tempApplicationEntity_id INT NULL;

UPDATE report_projectversion SET tempApplicationEntity_id = projectVersion_id;

ALTER TABLE report_projectversion DROP COLUMN projectVersion_id;

ALTER TABLE report_projectversion ADD applicationEntity_id INT NULL;

UPDATE report_projectversion SET applicationEntity_id = tempApplicationEntity_id;

ALTER TABLE report_projectversion MODIFY applicationEntity_id INT NOT NULL;

ALTER TABLE report_projectversion DROP COLUMN tempApplicationEntity_id;

ALTER TABLE report_projectversion RENAME report_applicationentity;

ALTER TABLE report_applicationentity ADD PRIMARY KEY (savedReport_id, applicationEntity_id);

ALTER TABLE report_applicationentity ADD CONSTRAINT rpae_ae FOREIGN KEY (applicationEntity_id) REFERENCES applicationentity (id) ON DELETE CASCADE;

ALTER TABLE report_applicationentity ADD CONSTRAINT RefSavedRepPV FOREIGN KEY (savedReport_id) REFERENCES savedreport (id) ON DELETE CASCADE;

UPDATE permission SET name = 'PERM_APPLICATION_ENTITY_REPORT_VIEW' WHERE name='PERM_PROJECT_VERSION_REPORT_VIEW';

UPDATE permission SET name = 'PERM_APPLICATION_ENTITY_REPORT_DELETE' WHERE name='PERM_PROJECT_VERSION_REPORT_DELETE';

UPDATE permission SET name = 'PERM_APPLICATION_ENTITY_REPORT_VIEW_ALL' WHERE name='PERM_PROJECT_VERSION_REPORT_VIEW_ALL';

UPDATE permission SET name = 'PERM_APPLICATION_ENTITY_REPORT_DELETE_ALL' WHERE name='PERM_PROJECT_VERSION_REPORT_DELETE_ALL';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_12', 'hp', 'dbF360_3.6.0.xml', NOW(), 75, '8:3a6eb3595d4e58f0696f29c42f08248e', 'dropPrimaryKey constraintName=PK205, tableName=report_projectversion; addColumn tableName=report_projectversion; update tableName=report_projectversion; dropColumn columnName=projectVersion_id, tableName=report_projectversion; addColumn tableName=...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_13::hp
ALTER TABLE issue MODIFY triggerDefinition LONGBLOB;

ALTER TABLE issue MODIFY attackTriggerDefinition LONGBLOB;

ALTER TABLE issue MODIFY reproStepDefinition LONGBLOB;

ALTER TABLE scan_issue MODIFY triggerDefinition LONGBLOB;

ALTER TABLE scan_issue MODIFY attackTriggerDefinition LONGBLOB;

ALTER TABLE scan_issue MODIFY reproStepDefinition LONGBLOB;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_13', 'hp', 'dbF360_3.6.0.xml', NOW(), 77, '8:83bd9b506c91773dcc79ad4b8c9e5ef2', 'modifyDataType columnName=triggerDefinition, tableName=issue; modifyDataType columnName=attackTriggerDefinition, tableName=issue; modifyDataType columnName=reproStepDefinition, tableName=issue; modifyDataType columnName=triggerDefinition, tableNam...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_14::hp
CREATE TABLE dynamicscan (id INT AUTO_INCREMENT NOT NULL, status VARCHAR(255) NULL, submitter VARCHAR(255) NULL, requestedDate datetime NULL, lastUpdateDate datetime NULL, projectVersion_id INT NOT NULL, objectVersion INT NULL, CONSTRAINT PK_DYNAMICSCAN PRIMARY KEY (id));

ALTER TABLE dynamicscan ADD CONSTRAINT ds_pv_fk FOREIGN KEY (projectVersion_id) REFERENCES projectversion (id) ON DELETE CASCADE;

CREATE TABLE dynamicscanparameter (id INT AUTO_INCREMENT NOT NULL, metaDef_id INT NOT NULL, textValue VARCHAR(2000) NULL, booleanValue CHAR(1) NULL, dynamicScan_id INT NULL, fileValueDocumentInfo_id INT NULL, dateValue date NULL, integerValue BIGINT NULL, objectVersion INT NULL, CONSTRAINT PK_DYNAMICSCANPARAMETER PRIMARY KEY (id));

ALTER TABLE dynamicscanparameter ADD CONSTRAINT dsp_docInfo_fk FOREIGN KEY (fileValueDocumentInfo_id) REFERENCES documentinfo (id) ON DELETE CASCADE;

ALTER TABLE dynamicscanparameter ADD CONSTRAINT dsp_mdef_fk FOREIGN KEY (metaDef_id) REFERENCES metadef (id);

ALTER TABLE dynamicscanparameter ADD CONSTRAINT dsp_ds_fk FOREIGN KEY (dynamicScan_id) REFERENCES dynamicscan (id) ON DELETE CASCADE;

CREATE TABLE dynamicscanparamselection (dynamicScanParam_id INT NOT NULL, metaOption_id INT NOT NULL);

ALTER TABLE dynamicscanparamselection ADD PRIMARY KEY (dynamicScanParam_id, metaOption_id);

ALTER TABLE dynamicscanparamselection ADD CONSTRAINT dsps_dsp_fk FOREIGN KEY (dynamicScanParam_id) REFERENCES dynamicscanparameter (id) ON DELETE CASCADE;

ALTER TABLE dynamicscanparamselection ADD CONSTRAINT dsps_mop_fk FOREIGN KEY (metaOption_id) REFERENCES metaoption (id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_14', 'hp', 'dbF360_3.6.0.xml', NOW(), 79, '8:e4ade4f78648d67b4d0190dd3790df81', 'createTable tableName=dynamicscan; addForeignKeyConstraint baseTableName=dynamicscan, constraintName=ds_pv_fk, referencedTableName=projectversion; createTable tableName=dynamicscanparameter; addForeignKeyConstraint baseTableName=dynamicscanparamet...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.6.0.xml::f360_3.6.0_15::hp
ALTER TABLE f360global ADD instanceGuid VARCHAR(2000) NULL, ADD wieInstanceGuid VARCHAR(2000) NULL, ADD wieInstanceUrl VARCHAR(2000) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.6.0_15', 'hp', 'dbF360_3.6.0.xml', NOW(), 81, '8:4c964ac07d9e1d88982f84de9a6e9493', 'addColumn tableName=f360global', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.7.0.xml::f360_3.7.0_0::hp
DROP VIEW baseIssueView;

DROP VIEW view_standards;

DROP VIEW defaultissueview;

ALTER TABLE issue ADD stackTraceTriggerDisplay_temp MEDIUMTEXT NULL;

ALTER TABLE scan_issue ADD stackTraceTriggerDisplay_temp MEDIUMTEXT NULL;

UPDATE issue SET stackTraceTriggerDisplay_temp = stackTraceTriggerDisplayText;

UPDATE scan_issue SET stackTraceTriggerDisplay_temp = stackTraceTriggerDisplayText;

ALTER TABLE issue DROP COLUMN stackTraceTriggerDisplayText;

ALTER TABLE scan_issue DROP COLUMN stackTraceTriggerDisplayText;

ALTER TABLE issue ADD stackTraceTriggerDisplayText MEDIUMTEXT NULL;

ALTER TABLE scan_issue ADD stackTraceTriggerDisplayText MEDIUMTEXT NULL;

UPDATE issue SET stackTraceTriggerDisplayText = stackTraceTriggerDisplay_temp;

UPDATE scan_issue SET stackTraceTriggerDisplayText = stackTraceTriggerDisplay_temp;

ALTER TABLE issue DROP COLUMN stackTraceTriggerDisplay_temp;

ALTER TABLE scan_issue DROP COLUMN stackTraceTriggerDisplay_temp;

CREATE VIEW baseIssueView AS SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence,
			i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName,
			i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet,
			i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink,
			i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus,
			i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden,
			i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader,
			i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition,
			i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion,
			i.cookie, i.mappedCategory, i.correlated
			FROM issue i;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.7.0_0', 'hp', 'dbF360_3.7.0.xml', NOW(), 83, '8:bafdbb0307d65b4b7c983fcc530f6a06', 'dropView viewName=baseIssueView; dropView viewName=view_standards; dropView viewName=defaultissueview; addColumn tableName=issue; addColumn tableName=scan_issue; update tableName=issue; update tableName=scan_issue; dropColumn columnName=stackTrace...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_3.7.0.xml::f360Mysql_3.7.0_0::hp
DROP FUNCTION getExternalCategories;

DELIMITER //
CREATE FUNCTION getExternalCategories(mc VARCHAR(255), externalListGuid VARCHAR(255))		    RETURNS VARCHAR(1024) NOT DETERMINISTIC
		    READS SQL DATA
		    RETURN (SELECT group_concat(CASE ecl.fromExtension WHEN 'Y' THEN ec.name || '*' ELSE ec.name END ORDER BY ec.orderingInfo, ', ')
		    FROM catpacklookup ecl, catpackexternalcategory ec
		    WHERE ecl.catpackexternalcategory_id=ec.id
		    AND ec.catpackexternallist_id=(SELECT id FROM catpackexternallist WHERE guid=externalListGuid)
		    AND ecl.mappedCategory = mc
		    GROUP BY ecl.mappedCategory)//
DELIMITER ;

CREATE OR REPLACE VIEW defaultissueview AS
		    SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence, i.kingdom, i.issueType, i.issueSubtype, i.analyzer,
		    i.lineNumber, i.taintFlag, i.packageName, i.functionName, i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus,
		    i.audienceSet, i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink, i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus, i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden, i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader, i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition, i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion, i.cookie, i.mappedCategory, i.correlated,
		    i.attackTriggerDefinition, i.vulnerableParameter, i.reproStepDefinition, i.stackTrace, i.stackTraceTriggerDisplayText, i.bug_id,
		    getExternalCategories(i.mappedCategory, '771C470C-9274-4580-8556-C023E4D3ADB4') AS OWASP2004,
		    getExternalCategories(i.mappedCategory, '1EB1EC0E-74E6-49A0-BCE5-E6603802987A') AS OWASP2007,
		    getExternalCategories(i.mappedCategory, 'FDCECA5E-C2A8-4BE8-BB26-76A8ECD0ED59') AS OWASP2010,
		    getExternalCategories(i.mappedCategory, '3ADB9EE4-5761-4289-8BD3-CBFCC593EBBC') AS CWE,
		    getExternalCategories(i.mappedCategory, '939EF193-507A-44E2-ABB7-C00B2168B6D8') AS SANS25,
		    getExternalCategories(i.mappedCategory, '72688795-4F7B-484C-88A6-D4757A6121CA') AS SANS2010,
		    getExternalCategories(i.mappedCategory, '9DC61E7F-1A48-4711-BBFD-E9DFF537871F') AS WASC,
		    getExternalCategories(i.mappedCategory, 'F2FA57EA-5AAA-4DDE-90A5-480BE65CE7E7') AS STIG,
		    getExternalCategories(i.mappedCategory, '58E2C21D-C70F-4314-8994-B859E24CF855') AS STIG34,
		    getExternalCategories(i.mappedCategory, 'CBDB9D4D-FC20-4C04-AD58-575901CAB531') AS PCI11,
		    getExternalCategories(i.mappedCategory, '57940BDB-99F0-48BF-BF2E-CFC42BA035E5') AS PCI12,
		    getExternalCategories(i.mappedCategory, '8970556D-7F9F-4EA7-8033-9DF39D68FF3E') AS PCI20,
		    getExternalCategories(i.mappedCategory, 'B40F9EE0-3824-4879-B9FE-7A789C89307C') AS FISMA
		    FROM issue i;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_3.7.0_0', 'hp', 'dbF360Mysql_3.7.0.xml', NOW(), 85, '8:9dcba547e27ed196e0d935ce115a5db4', 'sql; sql; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.7.0.xml::f360_3.7.0_1::hp
CREATE VIEW view_standards AS SELECT i.folder_id, i.id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence, i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName, i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet, i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink, i.sinkContext, i.userName, i.owasp2004, i.owasp2007, i.cwe, i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus, i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id, i.hidden, i.likelihood, i.impact, i.accuracy, i.wasc, i.sans25 AS sans2009, i.stig, i.pci11, i.pci12, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader, i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.attackTriggerDefinition, i.response, i.triggerDefinition, i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion, i.cookie, i.mappedCategory, i.owasp2010, i.fisma AS fips200, i.sans2010, i.correlated, i.pci20, i.vulnerableParameter, i.reproStepDefinition, i.stackTrace, i.stackTraceTriggerDisplayText
				from defaultissueview i
				where i.hidden='N' and i.suppressed='N' and i.scanStatus <> 'REMOVED' AND ((i.owasp2010 IS NOT NULL and upper(i.owasp2010) <> 'NONE') OR (i.fisma IS NOT NULL AND upper(i.fisma) <> 'NONE') OR (i.sans25 IS NOT NULL AND upper(i.sans25) <> 'NONE') OR (i.sans2010 IS NOT NULL AND upper(i.sans2010) <> 'NONE') OR (i.pci20 IS NOT NULL AND upper(i.pci20) <> 'NONE'));

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.7.0_1', 'hp', 'dbF360_3.7.0.xml', NOW(), 87, '8:f13eaf8c284399ab681da5b260469972', 'createView viewName=view_standards', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.7.0.xml::f360_3.7.0_3::hp
UPDATE permissiontemplate SET allApplicationRole = 'N' WHERE allApplicationRole IS NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.7.0_3', 'hp', 'dbF360_3.7.0.xml', NOW(), 89, '8:ac41c03c92e1e5f2c00ac2dddbed6c4b', 'update tableName=permissiontemplate', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.8.0.xml::f360_3.8.0_0::hp
DROP VIEW baseIssueView;

ALTER TABLE issue ADD manual VARCHAR(1) NULL;

ALTER TABLE scan_issue ADD manual VARCHAR(1) NULL;

CREATE VIEW baseIssueView AS SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence,
			i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName,
			i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet,
			i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink,
			i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus,
			i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden,
			i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader,
			i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition,
			i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion,
			i.cookie, i.mappedCategory, i.correlated, i.manual
			FROM issue i;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.8.0_0', 'hp', 'dbF360_3.8.0.xml', NOW(), 91, '8:004ce12f74c17fd10fecbca34092d737', 'dropView viewName=baseIssueView; addColumn tableName=issue; addColumn tableName=scan_issue; createView viewName=baseIssueView', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.8.0.xml::f360_3.8.0_1::hp
DROP VIEW baseIssueView;

CREATE VIEW baseIssueView AS SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence,
			i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName,
			i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet,
			i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink,
			i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus,
			i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden,
			i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader,
			i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition,
			i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion,
			i.cookie, i.mappedCategory, i.correlated, i.manual
			FROM issue i;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.8.0_1', 'hp', 'dbF360_3.8.0.xml', NOW(), 93, '8:efb009c875aa446542c933a113558083', 'dropView viewName=baseIssueView; createView viewName=baseIssueView', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.8.0.xml::f360_3.8.0_2::hp
CREATE TABLE systemsetting (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, settingType VARCHAR(255) NOT NULL, objectVersion INT NOT NULL, CONSTRAINT PK_SYSTEMSETTING PRIMARY KEY (id));

ALTER TABLE systemsetting ADD CONSTRAINT uq_systemSetting UNIQUE (name);

CREATE TABLE systemsettingvalue (id INT AUTO_INCREMENT NOT NULL, systemSetting_id INT NOT NULL, objectVersion INT NOT NULL, CONSTRAINT PK_SYSTEMSETTINGVALUE PRIMARY KEY (id));

ALTER TABLE systemsettingvalue ADD CONSTRAINT systemSettingValueRef FOREIGN KEY (systemSetting_id) REFERENCES systemsetting (id) ON DELETE CASCADE;

ALTER TABLE systemsettingvalue ADD CONSTRAINT uq_systemSettingValue UNIQUE (systemSetting_id);

CREATE TABLE systemsettingshortstringvalue (systemSettingValue_id INT NOT NULL, stringValue VARCHAR(255) NULL, CONSTRAINT PK_SYSSETSHORTSTRVALUE PRIMARY KEY (systemSettingValue_id));

ALTER TABLE systemsettingshortstringvalue ADD CONSTRAINT systemSettingStringValueRef FOREIGN KEY (systemSettingValue_id) REFERENCES systemsettingvalue (id) ON DELETE CASCADE;

CREATE TABLE systemsettinglongstringvalue (systemSettingValue_id INT NOT NULL, stringValue VARCHAR(255) NULL, CONSTRAINT PK_SYSSETLONGSTRINGVALUE PRIMARY KEY (systemSettingValue_id));

ALTER TABLE systemsettinglongstringvalue ADD CONSTRAINT sysSetLongStringValueRef FOREIGN KEY (systemSettingValue_id) REFERENCES systemsettingvalue (id) ON DELETE CASCADE;

CREATE TABLE systemsettingbooleanvalue (systemSettingValue_id INT NOT NULL, booleanValue CHAR(1) NULL, CONSTRAINT PK_SYSSETBOOLEANVALUE PRIMARY KEY (systemSettingValue_id));

ALTER TABLE systemsettingbooleanvalue ADD CONSTRAINT sysSetBooleanValueRef FOREIGN KEY (systemSettingValue_id) REFERENCES systemsettingvalue (id) ON DELETE CASCADE;

CREATE TABLE systemsettingfilevalue (systemSettingValue_id INT NOT NULL, fileValue MEDIUMBLOB NULL, fileName VARCHAR(255) NULL, CONSTRAINT PK_SYSSETFILEVALUE PRIMARY KEY (systemSettingValue_id));

ALTER TABLE systemsettingfilevalue ADD CONSTRAINT sysSetFileValueRef FOREIGN KEY (systemSettingValue_id) REFERENCES systemsettingvalue (id) ON DELETE CASCADE;

CREATE TABLE systemsettingmultichoiceoption (id INT AUTO_INCREMENT NOT NULL, setting_id INT NOT NULL, sortOrder INT NULL, optionValue VARCHAR(255) NULL, objectVersion INT NOT NULL, CONSTRAINT PK_SYSSETMULTICHOICEOPTION PRIMARY KEY (id));

ALTER TABLE systemsettingmultichoiceoption ADD CONSTRAINT sysSetMultiChoiceOptionSetRef FOREIGN KEY (setting_id) REFERENCES systemsetting (id) ON DELETE CASCADE;

CREATE TABLE systemsettingmultichoicevalue (systemSettingValue_id INT NOT NULL, selectedOption_id INT NULL, CONSTRAINT PK_SYSSETMULTICHOICEVALUE PRIMARY KEY (systemSettingValue_id));

ALTER TABLE systemsettingmultichoicevalue ADD CONSTRAINT sysSetMultiChoiceValOptRef FOREIGN KEY (selectedOption_id) REFERENCES systemsettingmultichoiceoption (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.8.0_2', 'hp', 'dbF360_3.8.0.xml', NOW(), 95, '8:ef639e48f95f16b7a94224e6381c409f', 'createTable tableName=systemsetting; addUniqueConstraint constraintName=uq_systemSetting, tableName=systemsetting; createTable tableName=systemsettingvalue; addForeignKeyConstraint baseTableName=systemsettingvalue, constraintName=systemSettingValu...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.8.0.xml::f360_3.8.0_3::hp
ALTER TABLE fortifyuser ADD userType VARCHAR(32) NULL;

UPDATE fortifyuser SET userType = 'LOCAL';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.8.0_3', 'hp', 'dbF360_3.8.0.xml', NOW(), 97, '8:74bb0bdeb502ebce1bdf08818fa9136c', 'addColumn tableName=fortifyuser; update tableName=fortifyuser', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.8.0.xml::f360_3.8.0_4::hp
CREATE TABLE bbstemplate (id INT AUTO_INCREMENT NOT NULL, guid VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, issueSelectionFilter VARCHAR(255) NOT NULL, objectVersion INT NULL, publishVersion INT NULL, CONSTRAINT bbstemplate_pk PRIMARY KEY (id), CONSTRAINT bbstemplate_guid_key UNIQUE (guid));

CREATE TABLE bbstemplateissuegrouping (bbsTemplate_id INT NOT NULL, attributeName VARCHAR(255) NOT NULL, CONSTRAINT bbstig_pk PRIMARY KEY (bbsTemplate_id, attributeName));

CREATE TABLE bbstrategy (id INT AUTO_INCREMENT NOT NULL, projectVersion_id INT NOT NULL, issueSelectionFilter VARCHAR(255) NOT NULL, CONSTRAINT bbstrategy_pk PRIMARY KEY (id), CONSTRAINT bbstrategy_pvid_key UNIQUE (projectVersion_id));

CREATE TABLE bbstrategyissuegrouping (bbStrategy_id INT NOT NULL, attributeName VARCHAR(255) NOT NULL, CONSTRAINT bbsig_pk PRIMARY KEY (bbStrategy_id, attributeName));

CREATE TABLE bbstrategyparametervalue (id INT AUTO_INCREMENT NOT NULL, bbStrategy_id INT NOT NULL, parameterIdentifier VARCHAR(255) NOT NULL, parameterValue VARCHAR(255) NULL, sortOrder INT NOT NULL, CONSTRAINT bbsav_pk PRIMARY KEY (id));

CREATE TABLE bugstatemgmtconfig (id INT AUTO_INCREMENT NOT NULL, projectVersion_id INT NOT NULL, username VARCHAR(255) NULL, password VARCHAR(255) NULL, CONSTRAINT bugstatemgmtconfig_pk PRIMARY KEY (id), CONSTRAINT bugstatemgmtconfig_pvid_key UNIQUE (projectVersion_id));

ALTER TABLE bbstemplateissuegrouping ADD CONSTRAINT RefBBST_BBSTIG FOREIGN KEY (bbsTemplate_id) REFERENCES bbstemplate (id) ON DELETE CASCADE;

ALTER TABLE bbstrategyissuegrouping ADD CONSTRAINT RefBBS_BBSIG FOREIGN KEY (bbStrategy_id) REFERENCES bbstrategy (id) ON DELETE CASCADE;

ALTER TABLE bbstrategyparametervalue ADD CONSTRAINT RefBBS_BBSAV FOREIGN KEY (bbStrategy_id) REFERENCES bbstrategy (id) ON DELETE CASCADE;

ALTER TABLE bbstrategy ADD CONSTRAINT RefBBS_PV FOREIGN KEY (projectVersion_id) REFERENCES projectversion (id) ON DELETE CASCADE;

ALTER TABLE bbstrategyparametervalue ADD CONSTRAINT bbstrategyav_id_name_key UNIQUE (bbStrategy_id, parameterIdentifier);

ALTER TABLE bugstatemgmtconfig ADD CONSTRAINT Refbugstatemgmt_PV FOREIGN KEY (projectVersion_id) REFERENCES projectversion (id) ON DELETE CASCADE;

ALTER TABLE projectversion ADD batchBugEnabled CHAR(1) DEFAULT 'N' NULL, ADD bugStateManagementEnabled CHAR(1) DEFAULT 'N' NULL;

UPDATE projectversion SET batchBugEnabled = 'N', bugStateManagementEnabled = 'N';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.8.0_4', 'hp', 'dbF360_3.8.0.xml', NOW(), 99, '8:3ab3ed73241e46580b7cb1c6b3be9e8f', 'createTable tableName=bbstemplate; createTable tableName=bbstemplateissuegrouping; createTable tableName=bbstrategy; createTable tableName=bbstrategyissuegrouping; createTable tableName=bbstrategyparametervalue; createTable tableName=bugstatemgmtc...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.8.0.xml::f360_3.8.0_5::hp
ALTER TABLE issue DROP FOREIGN KEY fk_issue_bug;

ALTER TABLE issue ADD CONSTRAINT fk_issue_bug FOREIGN KEY (bug_id) REFERENCES bug (id) ON DELETE SET NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.8.0_5', 'hp', 'dbF360_3.8.0.xml', NOW(), 101, '8:5c68a02f5eabcab4cf0854c95260c00c', 'dropForeignKeyConstraint baseTableName=issue, constraintName=fk_issue_bug; addForeignKeyConstraint baseTableName=issue, constraintName=fk_issue_bug, referencedTableName=bug', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.8.0.xml::f360_3.8.0_6::hp
CREATE INDEX RTEA_DOCINFIID_IND ON runtimeeventarchive(documentInfo_id);

CREATE INDEX AUDIT_ATT_DOCINFIID_IND ON auditattachment(documentInfo_id);

CREATE INDEX DYN_SCAN_PARAM_DOCINFIID_IND ON dynamicscanparameter(fileValueDocumentInfo_id);

CREATE INDEX ARTIFACT_DOCINFIID_IND ON artifact(documentInfo_id);

CREATE INDEX DOCARTIFACT_DOCINFIID_IND ON documentartifact(documentInfo_id);

CREATE INDEX PROJECTTEMPLATE_DOCINFIID_IND ON projecttemplate(documentInfo_id);

CREATE INDEX RULEPACK_DOCINFIID_IND ON rulepack(documentInfo_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.8.0_6', 'hp', 'dbF360_3.8.0.xml', NOW(), 103, '8:d99fa6fd7aeea6e84b6134a1d0a4452f', 'createIndex indexName=RTEA_DOCINFIID_IND, tableName=runtimeeventarchive; createIndex indexName=AUDIT_ATT_DOCINFIID_IND, tableName=auditattachment; createIndex indexName=DYN_SCAN_PARAM_DOCINFIID_IND, tableName=dynamicscanparameter; createIndex inde...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.8.0.xml::f360_3.8.0_7::hp
CREATE INDEX ISSUE_BUG_IND ON issue(bug_id);

CREATE INDEX PRJVERSIONCRTN_PRJVERSION_IND ON projectversioncreation(previousProjectVersion_id);

CREATE INDEX ACTIVITYINSTANCE_ACTIVITY_IND ON activityinstance(activity_id);

CREATE INDEX ALERTHISTORY_ALERT_IND ON alerthistory(alert_id);

CREATE INDEX HOST_CONTROLLER_IND ON host(controller_id);

CREATE INDEX RUNTIMEEVENT_HOST_IND ON runtimeevent(host_id);

CREATE INDEX AUDITATTACHMENT_ISSUE_IND ON auditattachment(issue_id);

CREATE INDEX CNTRLLR_CNTRLLRKEYKEEPER_IND ON controller(controllerKeyKeeper_id);

CREATE INDEX MSRMNTINSTANCE_MSRMNT_IND ON measurementinstance(measurement_id);

CREATE INDEX PRJSTATEACTIVITY_MSRMNT_IND ON projectstateactivity(measurement_id);

CREATE INDEX PRJSTATEAI_MSRMNT_IND ON projectstateai(measurement_id);

CREATE INDEX METADEF_METADEF_IND ON metadef(parent_id);

CREATE INDEX PYLOADENTRY_PYLOADARTIFACT_IND ON payloadentry(artifact_id);

CREATE INDEX PYLOADMSG_PYLOADARTIFACT_IND ON payloadmessage(artifact_id);

CREATE INDEX CRRLTNRESULT_PRJVERSION_IND ON correlationresult(projectVersion_id);

CREATE INDEX DYNASSESSMENT_PRJVERSION_IND ON dynamicassessment(projectVersion_id);

CREATE INDEX PYLOADARTIFACT_PRJVERSION_IND ON payloadartifact(projectVersion_id);

CREATE INDEX SAVEDEVIDENCE_PRJTVERSION_IND ON savedevidence(projectVersion_id);

CREATE INDEX SAVEDREPORT_RPRTDEFINITION_IND ON savedreport(reportDefinition_id);

CREATE INDEX REQTEMPLTINSTANCE_REQTMPLT_IND ON requirementtemplateinstance(requirementTemplate_id);

CREATE INDEX CONEVENTHNDLR_RUNTIMECFG_IND ON consoleeventhandler(runtimeConfiguration_id);

CREATE INDEX FEDERATION_RUNTIMECFG_IND ON federation(runtimeConfiguration_id);

CREATE INDEX RUNTIMESETTING_RUNTIMECFG_IND ON runtimesetting(runtimeConfiguration_id);

CREATE INDEX PREF_PAGE_USERPREFERENCE_IND ON pref_page(pref_id);

CREATE INDEX QRTZ_TRGGRS_QRTZ_JOB_DTLS_IND ON QRTZ_TRIGGERS(JOB_NAME, JOB_GROUP);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.8.0_7', 'hp', 'dbF360_3.8.0.xml', NOW(), 105, '8:7e95b408a5d165ff95820d0421b8c19e', 'createIndex indexName=ISSUE_BUG_IND, tableName=issue; createIndex indexName=PRJVERSIONCRTN_PRJVERSION_IND, tableName=projectversioncreation; createIndex indexName=ACTIVITYINSTANCE_ACTIVITY_IND, tableName=activityinstance; createIndex indexName=ALE...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.8.0.xml::f360_3.8.0_8::hp
INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.8.0_8', 'hp', 'dbF360_3.8.0.xml', NOW(), 107, '8:c1174ac63d7ac70d4b30dee2f8c63d46', 'sql', '', 'MARK_RAN', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.8.0.xml::f360_3.8.0_9::hp
ALTER TABLE bugtrackerconfig ADD tempProjectVersionId INT NULL;

UPDATE bugtrackerconfig SET tempProjectVersionId = projectVersion_Id;

ALTER TABLE bugtrackerconfig MODIFY projectVersion_Id INT NULL;

ALTER TABLE bugtrackerconfig DROP FOREIGN KEY fk_bugtc_projectversion;

ALTER TABLE bugtrackerconfig DROP COLUMN projectVersion_Id;

ALTER TABLE bugtrackerconfig ADD projectVersion_id INT DEFAULT 1 NOT NULL;

UPDATE bugtrackerconfig SET projectVersion_id = tempProjectVersionId;

ALTER TABLE bugtrackerconfig DROP COLUMN tempProjectVersionId;

ALTER TABLE bugtrackerconfig ADD CONSTRAINT fk_bugtc_projectversion FOREIGN KEY (projectVersion_id) REFERENCES projectversion (id) ON DELETE CASCADE;

CREATE INDEX BUGTRACKER_CFG_PRJVERSION_IND ON bugtrackerconfig(projectVersion_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.8.0_9', 'hp', 'dbF360_3.8.0.xml', NOW(), 109, '8:0f2a68adf8980280d7a4b71cd9d1a18d', 'addColumn tableName=bugtrackerconfig; update tableName=bugtrackerconfig; dropNotNullConstraint columnName=projectVersion_Id, tableName=bugtrackerconfig; dropForeignKeyConstraint baseTableName=bugtrackerconfig, constraintName=fk_bugtc_projectversio...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.8.0.xml::f360_3.8.0_11::hp
CREATE TABLE batchbugsubmission (batchId VARCHAR(255) NOT NULL, sequence INT NOT NULL, projectVersion_id INT NOT NULL, bugSubmission MEDIUMBLOB NOT NULL, CONSTRAINT batchbugsubmission_pk PRIMARY KEY (batchId, sequence));

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.8.0_11', 'hp', 'dbF360_3.8.0.xml', NOW(), 111, '8:dae7ca55b23f132a4597bc13ba9181d2', 'createTable tableName=batchbugsubmission', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.9.0.xml::f360_3.9.0_1::hp_i
CREATE INDEX FK_idx_auditvalue_issue ON auditvalue(issue_id);

CREATE INDEX FK_idx_issuecache_issue ON issuecache(issue_id);

CREATE INDEX FK_idx_fprscan_artifact ON fpr_scan(artifact_id);

CREATE INDEX FK_idx_pvrule_ruledesc ON projectversion_rule(rule_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.9.0_1', 'hp_i', 'dbF360_3.9.0.xml', NOW(), 113, '8:3045981aa4514a5bb59a59afb7f116c4', 'createIndex indexName=FK_idx_auditvalue_issue, tableName=auditvalue; createIndex indexName=FK_idx_issuecache_issue, tableName=issuecache; createIndex indexName=FK_idx_fprscan_artifact, tableName=fpr_scan; createIndex indexName=FK_idx_pvrule_rulede...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.9.0.xml::f360_3.9.0_2::hp_i
CREATE INDEX FK_idx_dynamicscan_pv ON dynamicscan(projectVersion_id);

CREATE INDEX FK_idx_finding_pv ON finding(projectVersion_id);

CREATE INDEX FK_idx_foldercountcache_pv ON foldercountcache(projectVersion_id);

CREATE INDEX FK_idx_personaassignment_pv ON personaassignment(projectVersion_id);

CREATE INDEX FK_idx_prefpv_pv ON pref_projectversion(projectVersion_id);

CREATE INDEX FK_idx_pvattr_pv ON projectversion_attr(projectVersion_id);

CREATE INDEX FK_idx_pvdependency_childpv ON projectversiondependency(childProjectVersion_id);

CREATE INDEX FK_idx_pvdependency_parentpv ON projectversiondependency(parentProjectVersion_id);

CREATE INDEX FK_idx_rtcomment_pv ON requirementtemplatecomment(projectVersion_id);

CREATE INDEX FK_idx_rtsignoff_pv ON requirementtemplatesignoff(projectVersion_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.9.0_2', 'hp_i', 'dbF360_3.9.0.xml', NOW(), 115, '8:01fac82e9eb7a3b14f01660d47945a77', 'createIndex indexName=FK_idx_dynamicscan_pv, tableName=dynamicscan; createIndex indexName=FK_idx_finding_pv, tableName=finding; createIndex indexName=FK_idx_foldercountcache_pv, tableName=foldercountcache; createIndex indexName=FK_idx_personaassig...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.9.0.xml::f360_3.9.0_3::hp_i
CREATE INDEX FK_idx_timelapseevent_ai ON timelapse_event(activityInstance_id);

CREATE INDEX FK_idx_dynscanparam_dynscan ON dynamicscanparameter(dynamicScan_id);

CREATE INDEX FK_idx_dynscanparam_metadef ON dynamicscanparameter(metaDef_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.9.0_3', 'hp_i', 'dbF360_3.9.0.xml', NOW(), 117, '8:65ddbaa7736f7424149487bfe3db8ac4', 'createIndex indexName=FK_idx_timelapseevent_ai, tableName=timelapse_event; createIndex indexName=FK_idx_dynscanparam_dynscan, tableName=dynamicscanparameter; createIndex indexName=FK_idx_dynscanparam_metadef, tableName=dynamicscanparameter', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_3.9.0.xml::f360Mysql_3.9.0_0::hp_i
DROP PROCEDURE updateScanIssueIds;

DELIMITER //
CREATE PROCEDURE updateScanIssueIds                (p_scan_id INT,
                 p_projectVersion_Id INT
                )
            BEGIN
                UPDATE scan_issue si, issue SET si.issue_id=issue.id
                WHERE issue.projectVersion_id = p_projectVersion_Id
                  AND issue.engineType = si.engineType
                  AND si.issueInstanceId = issue.issueInstanceId
                  AND si.scan_id = p_scan_id;
            END//
DELIMITER ;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_3.9.0_0', 'hp_i', 'dbF360Mysql_3.9.0.xml', NOW(), 119, '8:b591df5d3c9da9636d5077adae375ecf', 'sql; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.9.0.xml::f360_3.9.0_4::hp_i
ALTER TABLE sourcefilemap DROP PRIMARY KEY;

ALTER TABLE sourcefilemap ADD PRIMARY KEY (scan_id, filePath);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.9.0_4', 'hp_i', 'dbF360_3.9.0.xml', NOW(), 121, '8:f1a0dbe8a958fc93a18688cc8d635a40', 'dropPrimaryKey constraintName=PK119, tableName=sourcefilemap; addPrimaryKey constraintName=PK119, tableName=sourcefilemap', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.9.0.xml::f360_3.9.0_5::hp_i
CREATE INDEX FK_idx_measurementvar_var ON measurement_variable(variable_id);

CREATE INDEX FK_idx_measurehist_measure ON measurementhistory(measurement_id);

CREATE INDEX FK_idx_varinstance_ai ON variableinstance(ai_id);

CREATE INDEX FK_idx_varhistory_var ON variablehistory(variable_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.9.0_5', 'hp_i', 'dbF360_3.9.0.xml', NOW(), 123, '8:43535f558082019bbb0fa63b0a6f5930', 'createIndex indexName=FK_idx_measurementvar_var, tableName=measurement_variable; createIndex indexName=FK_idx_measurehist_measure, tableName=measurementhistory; createIndex indexName=FK_idx_varinstance_ai, tableName=variableinstance; createIndex i...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.9.0.xml::f360_3.9.0_6::hp_i
ALTER TABLE f360global ADD wieServiceUser VARCHAR(100) NULL, ADD wieServicePassword VARCHAR(100) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.9.0_6', 'hp_i', 'dbF360_3.9.0.xml', NOW(), 125, '8:cb28726ef8e61bb33a9025e1d20d56c2', 'addColumn tableName=f360global', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.9.0.xml::f360_3.9.0_7::hp_i
ALTER TABLE analysisblob DROP PRIMARY KEY;

DELETE FROM analysisblob WHERE projectVersion_id NOT IN (SELECT id FROM projectversion);

ALTER TABLE analysisblob ADD PRIMARY KEY (projectVersion_id, engineType, issueInstanceId);

ALTER TABLE analysisblob ADD CONSTRAINT fk_analysisblob_pv FOREIGN KEY (projectVersion_id) REFERENCES projectversion (id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.9.0_7', 'hp_i', 'dbF360_3.9.0.xml', NOW(), 127, '8:d8c08d86e30e1e58b07263be165f9681', 'dropPrimaryKey constraintName=PK168, tableName=analysisblob; delete tableName=analysisblob; addPrimaryKey constraintName=PK168, tableName=analysisblob; addForeignKeyConstraint baseTableName=analysisblob, constraintName=fk_analysisblob_pv, referenc...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.9.0.xml::f360_3.9.0_8::hp_i
DELETE FROM scan_issue WHERE scan_id NOT IN (SELECT id FROM scan);

ALTER TABLE scan_issue ADD CONSTRAINT fk_scanissue_scan FOREIGN KEY (scan_id) REFERENCES scan (id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.9.0_8', 'hp_i', 'dbF360_3.9.0.xml', NOW(), 129, '8:db2cc01ecba732a55a88dbad0e4e41bd', 'delete tableName=scan_issue; addForeignKeyConstraint baseTableName=scan_issue, constraintName=fk_scanissue_scan, referencedTableName=scan', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.9.0.xml::f360_3.9.0_9_pre::hp_i
ALTER TABLE artifact DROP FOREIGN KEY RefPVArti;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.9.0_9_pre', 'hp_i', 'dbF360_3.9.0.xml', NOW(), 131, '8:3c3e052dfb75875b66e2b3d37a8b5f37', 'dropForeignKeyConstraint baseTableName=artifact, constraintName=RefPVArti', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.9.0.xml::f360_3.9.0_9::hp_i
DROP INDEX artifact_proj ON artifact;

CREATE INDEX artifact_proj_purged ON artifact(projectVersion_id, purged);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.9.0_9', 'hp_i', 'dbF360_3.9.0.xml', NOW(), 133, '8:97e89a1568a9ddc43d8e70ce00625652', 'dropIndex indexName=artifact_proj, tableName=artifact; createIndex indexName=artifact_proj_purged, tableName=artifact', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.9.0.xml::f360_3.9.0_9_post::hp_i
ALTER TABLE artifact ADD CONSTRAINT RefPVArti FOREIGN KEY (projectVersion_id) REFERENCES projectversion (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.9.0_9_post', 'hp_i', 'dbF360_3.9.0.xml', NOW(), 135, '8:8c00bc4690278c7b8096854f1115562f', 'addForeignKeyConstraint baseTableName=artifact, constraintName=RefPVArti, referencedTableName=projectversion', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.9.0.xml::f360_3.9.0_10::hp_i
CREATE INDEX IX_issue_folder_update ON issue(projectVersion_id, id);

CREATE INDEX IX_issue_conf_sev ON issue(projectVersion_id, confidence, severity);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.9.0_10', 'hp_i', 'dbF360_3.9.0.xml', NOW(), 137, '8:9bc0106dfd5235f7c267780f60d4868a', 'createIndex indexName=IX_issue_folder_update, tableName=issue; createIndex indexName=IX_issue_conf_sev, tableName=issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_3.9.0.xml::f360_3.9.0_11::hp_i
CREATE INDEX IX_issue_removeddate ON issue(projectVersion_id, removedDate, id);

DROP INDEX scanissueidkey ON scan_issue;

CREATE INDEX scanissueidkey ON scan_issue(scan_id, issue_id, engineType, issueInstanceId);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_3.9.0_11', 'hp_i', 'dbF360_3.9.0.xml', NOW(), 139, '8:528d139535cb8ea6b5e21435c80d9d1f', 'createIndex indexName=IX_issue_removeddate, tableName=issue; dropIndex indexName=scanissueidkey, tableName=scan_issue; createIndex indexName=scanissueidkey, tableName=scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_4::hp_main
INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_4', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 141, '8:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_5::hp_main
ALTER TABLE scan_issue ADD projectVersion_id INT NULL;

ALTER TABLE scan_issue ADD all_lob_hash INT NULL;

ALTER TABLE scan_issue ADD sibling INT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_5', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 143, '8:283adc7808b02aa602bae2a15c9cb993', 'addColumn tableName=scan_issue; addColumn tableName=scan_issue; addColumn tableName=scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_4.0.0_scan_issue_id.xml::f360Mysql_4.0.0_0::hp
ALTER TABLE scan_issue DROP FOREIGN KEY fk_scanissue_scan;

ALTER TABLE scan_issue DROP PRIMARY KEY;

alter table scan_issue add id Int NOT NULL AUTO_INCREMENT key;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_4.0.0_0', 'hp', 'dbF360Mysql_4.0.0_scan_issue_id.xml', NOW(), 145, '8:393224d96a3171a1fafe4fee3b9c6ab5', 'dropForeignKeyConstraint baseTableName=scan_issue, constraintName=fk_scanissue_scan; dropPrimaryKey tableName=scan_issue; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_6::hp_main
CREATE INDEX ScanIssueIssueIdKey ON scan_issue(issue_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_6', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 147, '8:a281abaae77283d3f686157a28056d13', 'createIndex indexName=ScanIssueIssueIdKey, tableName=scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_7::hp_main
ALTER TABLE scan_issue MODIFY scan_id INT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_7', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 149, '8:d32fd294d87a8b991460197849edc15e', 'dropNotNullConstraint columnName=scan_id, tableName=scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_8::hp_main
CREATE TABLE scan_issue_link (scan_id INT NOT NULL, scan_issue_id INT NOT NULL, CONSTRAINT PK_SCAN_ISSUE_LINK PRIMARY KEY (scan_id, scan_issue_id));

ALTER TABLE scan_issue_link ADD CONSTRAINT fk_scan_issue_link_scan FOREIGN KEY (scan_id) REFERENCES scan (id);

ALTER TABLE scan_issue_link ADD CONSTRAINT fk_scan_issue_link_issue FOREIGN KEY (scan_issue_id) REFERENCES scan_issue (id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_8', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 151, '8:f43d5192d1fa54834464cf1c66d846c9', 'createTable tableName=scan_issue_link; addForeignKeyConstraint baseTableName=scan_issue_link, constraintName=fk_scan_issue_link_scan, referencedTableName=scan; addForeignKeyConstraint baseTableName=scan_issue_link, constraintName=fk_scan_issue_lin...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_4.0.0.xml::f360Mysql_4.0.0_1::hp
update scan_issue set projectVersion_id = (select projectVersion_id from issue i where i.id = scan_issue.issue_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_4.0.0_1', 'hp', 'dbF360Mysql_4.0.0.xml', NOW(), 153, '8:78a15cf8f03ef0642b5b6dc192300957', 'sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_4.0.0.xml::f360Mysql_4.0.0_2::hp
DROP TABLE QRTZ_JOB_LISTENERS;

DROP TABLE QRTZ_TRIGGER_LISTENERS;

--  WARNING The following SQL may change each run and therefore is possibly incorrect and/or invalid:
--  WARNING The following SQL may change each run and therefore is possibly incorrect and/or invalid:
--  WARNING The following SQL may change each run and therefore is possibly incorrect and/or invalid:
--  WARNING The following SQL may change each run and therefore is possibly incorrect and/or invalid:
INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_4.0.0_2', 'hp', 'dbF360Mysql_4.0.0.xml', NOW(), 155, '8:09be7cc61a3eb02880bb8d89c717227c', 'dropTable tableName=QRTZ_JOB_LISTENERS; dropTable tableName=QRTZ_TRIGGER_LISTENERS; dropAllForeignKeyConstraints baseTableName=QRTZ_TRIGGERS; dropAllForeignKeyConstraints baseTableName=QRTZ_BLOB_TRIGGERS; dropAllForeignKeyConstraints baseTableName...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_4.0.0.xml::f360Mysql_4.0.0_3::hp
ALTER TABLE scan_issue MODIFY likelihood DECIMAL(8, 3);

ALTER TABLE issue MODIFY likelihood DECIMAL(8, 3);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_4.0.0_3', 'hp', 'dbF360Mysql_4.0.0.xml', NOW(), 157, '8:d1d87dc5de77ad647edb6aeb8a725ddd', 'modifyDataType columnName=likelihood, tableName=scan_issue; modifyDataType columnName=likelihood, tableName=issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_9::hp_main
DROP VIEW baseIssueView;

CREATE VIEW baseissueview AS SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence,
			i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName,
			i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet,
			i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink,
			i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus,
			i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden,
			i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader,
			i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition,
			i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion,
			i.cookie, i.mappedCategory, i.correlated, i.manual
			FROM issue i;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_9', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 159, '8:4b1eded266c7589bc28a65f3d8efe9fa', 'dropView viewName=baseIssueView; createView viewName=baseissueview', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_10::hp_main
CREATE TABLE tmp_scan_issue (scan_id INT NOT NULL, scan_issue_id INT NOT NULL, issue_id INT NULL);

ALTER TABLE tmp_scan_issue ADD CONSTRAINT uq_tmp_scan_issue UNIQUE (scan_id, scan_issue_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_10', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 161, '8:8a8bcabbcd3f8ff905f2319209477ebc', 'createTable tableName=tmp_scan_issue; addUniqueConstraint constraintName=uq_tmp_scan_issue, tableName=tmp_scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_11::hp_main
CREATE TABLE id_table (session_id INT NOT NULL, id INT NOT NULL);

CREATE INDEX idx_id_table_session_id ON id_table(session_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_11', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 163, '8:baa58d1cd7c9ca8f8900188d8e7e03ba', 'createTable tableName=id_table; createIndex indexName=idx_id_table_session_id, tableName=id_table', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_12::hp_main
CREATE VIEW scanissueview AS SELECT sil.scan_id, sil.scan_issue_id, si.issue_id, si.issueInstanceId, s.startDate, s.engineType, s.projectVersion_id
			FROM scan s
			INNER JOIN scan_issue_link sil ON sil.scan_id = s.id
			INNER JOIN scan_issue si ON si.id = sil.scan_issue_id;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_12', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 165, '8:9edd561d5ce8811420108cae06e0686c', 'createView viewName=scanissueview', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_13::hp_main
ALTER TABLE scan DROP FOREIGN KEY RefPVScan;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_13', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 167, '8:87789ca313737354946df2c82cacbd71', 'dropForeignKeyConstraint baseTableName=scan, constraintName=RefPVScan', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_14::hp_main
DROP INDEX scan_proj_date ON scan;

CREATE INDEX scan_proj_date ON scan(projectVersion_id, engineType, startDate);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_14', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 169, '8:af78dee440af1684e0a64da60cfbcd8c', 'dropIndex indexName=scan_proj_date, tableName=scan; createIndex indexName=scan_proj_date, tableName=scan', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_15::hp_main
ALTER TABLE scan ADD CONSTRAINT RefPVScan FOREIGN KEY (projectVersion_id) REFERENCES projectversion (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_15', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 171, '8:15ce5c46e70c35b1af047e2688fae47a', 'addForeignKeyConstraint baseTableName=scan, constraintName=RefPVScan, referencedTableName=projectversion', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_16::hp_main
CREATE INDEX idx_scan_issue_link_si_id ON scan_issue_link(scan_issue_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_16', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 173, '8:259f10440806a5b7ccc618838038b5ca', 'createIndex indexName=idx_scan_issue_link_si_id, tableName=scan_issue_link', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_17::hp_main
ALTER TABLE QRTZ_JOB_DETAILS DROP COLUMN IS_VOLATILE;

ALTER TABLE QRTZ_TRIGGERS DROP COLUMN IS_VOLATILE;

ALTER TABLE QRTZ_FIRED_TRIGGERS DROP COLUMN IS_VOLATILE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_17', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 175, '8:0fe46fa58cb9a192155024264dc9686d', 'dropColumn columnName=IS_VOLATILE, tableName=QRTZ_JOB_DETAILS; dropColumn columnName=IS_VOLATILE, tableName=QRTZ_TRIGGERS; dropColumn columnName=IS_VOLATILE, tableName=QRTZ_FIRED_TRIGGERS', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_18::hp_main
ALTER TABLE QRTZ_JOB_DETAILS ADD IS_NONCONCURRENT VARCHAR(1) NULL;

UPDATE QRTZ_JOB_DETAILS SET IS_NONCONCURRENT = IS_STATEFUL;

ALTER TABLE QRTZ_JOB_DETAILS ADD IS_UPDATE_DATA VARCHAR(1) NULL;

UPDATE QRTZ_JOB_DETAILS SET IS_UPDATE_DATA = IS_STATEFUL;

ALTER TABLE QRTZ_JOB_DETAILS DROP COLUMN IS_STATEFUL;

ALTER TABLE QRTZ_FIRED_TRIGGERS ADD IS_NONCONCURRENT VARCHAR(1) NULL;

UPDATE QRTZ_FIRED_TRIGGERS SET IS_NONCONCURRENT = IS_STATEFUL;

ALTER TABLE QRTZ_FIRED_TRIGGERS ADD IS_UPDATE_DATA VARCHAR(1) NULL;

UPDATE QRTZ_FIRED_TRIGGERS SET IS_UPDATE_DATA = IS_STATEFUL;

ALTER TABLE QRTZ_FIRED_TRIGGERS DROP COLUMN IS_STATEFUL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_18', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 177, '8:4d0c4abfb6c1fdf34db95eb4d5e6f8c2', 'addColumn tableName=QRTZ_JOB_DETAILS; addColumn tableName=QRTZ_JOB_DETAILS; dropColumn columnName=IS_STATEFUL, tableName=QRTZ_JOB_DETAILS; addColumn tableName=QRTZ_FIRED_TRIGGERS; addColumn tableName=QRTZ_FIRED_TRIGGERS; dropColumn columnName=IS_S...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_19::hp_main
ALTER TABLE QRTZ_BLOB_TRIGGERS ADD SCHED_NAME VARCHAR(120) DEFAULT 'scheduler' NOT NULL;

ALTER TABLE QRTZ_CALENDARS ADD SCHED_NAME VARCHAR(120) DEFAULT 'scheduler' NOT NULL;

ALTER TABLE QRTZ_CRON_TRIGGERS ADD SCHED_NAME VARCHAR(120) DEFAULT 'scheduler' NOT NULL;

ALTER TABLE QRTZ_FIRED_TRIGGERS ADD SCHED_NAME VARCHAR(120) DEFAULT 'scheduler' NOT NULL;

ALTER TABLE QRTZ_JOB_DETAILS ADD SCHED_NAME VARCHAR(120) DEFAULT 'scheduler' NOT NULL;

ALTER TABLE QRTZ_LOCKS ADD SCHED_NAME VARCHAR(120) DEFAULT 'scheduler' NOT NULL;

ALTER TABLE QRTZ_PAUSED_TRIGGER_GRPS ADD SCHED_NAME VARCHAR(120) DEFAULT 'scheduler' NOT NULL;

ALTER TABLE QRTZ_SCHEDULER_STATE ADD SCHED_NAME VARCHAR(120) DEFAULT 'scheduler' NOT NULL;

ALTER TABLE QRTZ_SIMPLE_TRIGGERS ADD SCHED_NAME VARCHAR(120) DEFAULT 'scheduler' NOT NULL;

ALTER TABLE QRTZ_TRIGGERS ADD SCHED_NAME VARCHAR(120) DEFAULT 'scheduler' NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_19', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 179, '8:13a646e3a1cb6c28ab6e257d1947de47', 'addColumn tableName=QRTZ_BLOB_TRIGGERS; addColumn tableName=QRTZ_CALENDARS; addColumn tableName=QRTZ_CRON_TRIGGERS; addColumn tableName=QRTZ_FIRED_TRIGGERS; addColumn tableName=QRTZ_JOB_DETAILS; addColumn tableName=QRTZ_LOCKS; addColumn tableName=...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_20::hp_main
ALTER TABLE QRTZ_JOB_DETAILS DROP PRIMARY KEY;

ALTER TABLE QRTZ_FIRED_TRIGGERS DROP PRIMARY KEY;

ALTER TABLE QRTZ_BLOB_TRIGGERS DROP PRIMARY KEY;

ALTER TABLE QRTZ_CRON_TRIGGERS DROP PRIMARY KEY;

ALTER TABLE QRTZ_SIMPLE_TRIGGERS DROP PRIMARY KEY;

ALTER TABLE QRTZ_CALENDARS DROP PRIMARY KEY;

ALTER TABLE QRTZ_LOCKS DROP PRIMARY KEY;

ALTER TABLE QRTZ_PAUSED_TRIGGER_GRPS DROP PRIMARY KEY;

ALTER TABLE QRTZ_SCHEDULER_STATE DROP PRIMARY KEY;

ALTER TABLE QRTZ_TRIGGERS DROP PRIMARY KEY;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_20', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 181, '8:c7a315c2bc8dfaf5be7c049b441715e0', 'dropPrimaryKey tableName=QRTZ_JOB_DETAILS; dropPrimaryKey tableName=QRTZ_FIRED_TRIGGERS; dropPrimaryKey tableName=QRTZ_BLOB_TRIGGERS; dropPrimaryKey tableName=QRTZ_CRON_TRIGGERS; dropPrimaryKey tableName=QRTZ_SIMPLE_TRIGGERS; dropPrimaryKey tableN...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_21::hp_main
ALTER TABLE QRTZ_JOB_DETAILS ADD PRIMARY KEY (SCHED_NAME, JOB_NAME, JOB_GROUP);

ALTER TABLE QRTZ_TRIGGERS ADD PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

ALTER TABLE QRTZ_TRIGGERS ADD CONSTRAINT qrtz_triggers_job_name_fkey FOREIGN KEY (SCHED_NAME, JOB_NAME, JOB_GROUP) REFERENCES QRTZ_JOB_DETAILS (SCHED_NAME, JOB_NAME, JOB_GROUP);

ALTER TABLE QRTZ_BLOB_TRIGGERS ADD PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

ALTER TABLE QRTZ_BLOB_TRIGGERS ADD CONSTRAINT qrtz_blobtrig_trig_name_fkey FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

ALTER TABLE QRTZ_CRON_TRIGGERS ADD PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

ALTER TABLE QRTZ_CRON_TRIGGERS ADD CONSTRAINT qrtz_crontrig_trig_name_fkey FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

ALTER TABLE QRTZ_SIMPLE_TRIGGERS ADD PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

ALTER TABLE QRTZ_SIMPLE_TRIGGERS ADD CONSTRAINT qrtz_simpletrig_trig_name_fkey FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

ALTER TABLE QRTZ_FIRED_TRIGGERS ADD PRIMARY KEY (SCHED_NAME, ENTRY_ID);

ALTER TABLE QRTZ_CALENDARS ADD PRIMARY KEY (SCHED_NAME, CALENDAR_NAME);

ALTER TABLE QRTZ_LOCKS ADD PRIMARY KEY (SCHED_NAME, LOCK_NAME);

ALTER TABLE QRTZ_PAUSED_TRIGGER_GRPS ADD PRIMARY KEY (SCHED_NAME, TRIGGER_GROUP);

ALTER TABLE QRTZ_SCHEDULER_STATE ADD PRIMARY KEY (SCHED_NAME, INSTANCE_NAME);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_21', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 183, '8:6aac098192dbb10f8859df80e1d6f4a0', 'addPrimaryKey constraintName=qrtz_job_details_pkey, tableName=QRTZ_JOB_DETAILS; addPrimaryKey constraintName=qrtz_triggers_pkey, tableName=QRTZ_TRIGGERS; addForeignKeyConstraint baseTableName=QRTZ_TRIGGERS, constraintName=qrtz_triggers_job_name_fk...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_22::hp_main
CREATE TABLE QRTZ_SIMPROP_TRIGGERS (SCHED_NAME VARCHAR(120) NOT NULL, TRIGGER_NAME VARCHAR(200) NOT NULL, TRIGGER_GROUP VARCHAR(200) NOT NULL, STR_PROP_1 VARCHAR(512) NULL, STR_PROP_2 VARCHAR(512) NULL, STR_PROP_3 VARCHAR(512) NULL, INT_PROP_1 INT NULL, INT_PROP_2 INT NULL, LONG_PROP_1 BIGINT NULL, LONG_PROP_2 BIGINT NULL, DEC_PROP_1 DECIMAL(13, 4) NULL, DEC_PROP_2 DECIMAL(13, 4) NULL, BOOL_PROP_1 VARCHAR(1) NULL, BOOL_PROP_2 VARCHAR(1) NULL);

ALTER TABLE QRTZ_SIMPROP_TRIGGERS ADD PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

ALTER TABLE QRTZ_SIMPROP_TRIGGERS ADD CONSTRAINT qrtz_simprop_triggers_fk FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_22', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 185, '8:460c49ce7f0dacabb896b7a9756f2922', 'createTable tableName=QRTZ_SIMPROP_TRIGGERS; addPrimaryKey tableName=QRTZ_SIMPROP_TRIGGERS; addForeignKeyConstraint baseTableName=QRTZ_SIMPROP_TRIGGERS, constraintName=qrtz_simprop_triggers_fk, referencedTableName=QRTZ_TRIGGERS', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_23::hp_main
CREATE INDEX idx_qrtz_ft_inst_job_req_rcvry ON QRTZ_FIRED_TRIGGERS(SCHED_NAME, INSTANCE_NAME, REQUESTS_RECOVERY);

CREATE INDEX idx_qrtz_ft_jg ON QRTZ_FIRED_TRIGGERS(SCHED_NAME, JOB_GROUP);

CREATE INDEX idx_qrtz_ft_j_g ON QRTZ_FIRED_TRIGGERS(SCHED_NAME, JOB_NAME, JOB_GROUP);

CREATE INDEX idx_qrtz_ft_tg ON QRTZ_FIRED_TRIGGERS(SCHED_NAME, TRIGGER_GROUP);

CREATE INDEX idx_qrtz_ft_trig_inst_name ON QRTZ_FIRED_TRIGGERS(SCHED_NAME, INSTANCE_NAME);

CREATE INDEX idx_qrtz_ft_t_g ON QRTZ_FIRED_TRIGGERS(SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

CREATE INDEX idx_qrtz_j_grp ON QRTZ_JOB_DETAILS(SCHED_NAME, JOB_GROUP);

CREATE INDEX idx_qrtz_j_req_recovery ON QRTZ_JOB_DETAILS(SCHED_NAME, REQUESTS_RECOVERY);

CREATE INDEX idx_qrtz_t_c ON QRTZ_TRIGGERS(SCHED_NAME, CALENDAR_NAME);

CREATE INDEX idx_qrtz_t_g ON QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_GROUP);

CREATE INDEX idx_qrtz_t_jg ON QRTZ_TRIGGERS(SCHED_NAME, JOB_GROUP);

CREATE INDEX idx_qrtz_t_NEXT_FIRE_TIME ON QRTZ_TRIGGERS(SCHED_NAME, NEXT_FIRE_TIME);

CREATE INDEX idx_qrtz_t_nft_misfire ON QRTZ_TRIGGERS(SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME);

CREATE INDEX idx_qrtz_t_nft_st ON QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_STATE, NEXT_FIRE_TIME);

CREATE INDEX idx_qrtz_t_nft_st_misfire ON QRTZ_TRIGGERS(SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_STATE);

CREATE INDEX idx_qrtz_t_nft_st_misfire_grp ON QRTZ_TRIGGERS(SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_GROUP, TRIGGER_STATE);

CREATE INDEX idx_qrtz_t_n_g_state ON QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_GROUP, TRIGGER_STATE);

CREATE INDEX idx_qrtz_t_n_state ON QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP, TRIGGER_STATE);

CREATE INDEX idx_qrtz_t_state ON QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_STATE);

CREATE INDEX idx_qrtz_t_j ON QRTZ_TRIGGERS(SCHED_NAME, JOB_NAME, JOB_GROUP);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_23', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 187, '8:551944496a5a331649f1b30da63263ee', 'createIndex indexName=idx_qrtz_ft_inst_job_req_rcvry, tableName=QRTZ_FIRED_TRIGGERS; createIndex indexName=idx_qrtz_ft_jg, tableName=QRTZ_FIRED_TRIGGERS; createIndex indexName=idx_qrtz_ft_j_g, tableName=QRTZ_FIRED_TRIGGERS; createIndex indexName=i...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_24::hp_main
ALTER TABLE artifact ADD lastCompletedStep INT DEFAULT 0 NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_24', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 189, '8:4d079a2f8872a2543f9faeca15aaa887', 'addColumn tableName=artifact', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_25::hp_main
UPDATE QRTZ_JOB_DETAILS SET REQUESTS_RECOVERY = '1' WHERE JOB_NAME = 'JOB_ARTIFACTUPLOAD' AND JOB_GROUP = 'JOBGROUP_ARTIFACTUPLOAD';

UPDATE QRTZ_JOB_DETAILS SET REQUESTS_RECOVERY = '1' WHERE JOB_NAME = 'JOB_SOURCEUPLOAD' AND JOB_GROUP = 'JOBGROUP_SOURCEUPLOAD';

UPDATE QRTZ_JOB_DETAILS SET REQUESTS_RECOVERY = '1' WHERE JOB_NAME = 'JOB_ARTIFACTPURGE' AND JOB_GROUP = 'JOBGROUP_ARTIFACTPURGE';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_25', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 191, '8:23d3bbe65bc61941bc939eb90d6669a9', 'update tableName=QRTZ_JOB_DETAILS; update tableName=QRTZ_JOB_DETAILS; update tableName=QRTZ_JOB_DETAILS', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_26::hp_main
ALTER TABLE projectversion ADD CONSTRAINT project_projectversion_fkey FOREIGN KEY (project_id) REFERENCES project (id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_26', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 193, '8:c4eb71bc1eeace1c3f757689447757fa', 'addForeignKeyConstraint baseTableName=projectversion, constraintName=project_projectversion_fkey, referencedTableName=project', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_27::hp_main
ALTER TABLE iidmigration ADD engineType VARCHAR(20) DEFAULT 'SCA' NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_27', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 195, '8:4993b25e2109301a9c976cc2b0518936', 'addColumn tableName=iidmigration', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_28::hp_main
ALTER TABLE scan_issue MODIFY source VARCHAR(4000);

ALTER TABLE scan_issue MODIFY sink VARCHAR(4000);

ALTER TABLE issue MODIFY source VARCHAR(4000);

ALTER TABLE issue MODIFY sink VARCHAR(4000);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_28', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 197, '8:f482db2eb44301aefeac78e746a17c69', 'modifyDataType columnName=source, tableName=scan_issue; modifyDataType columnName=sink, tableName=scan_issue; modifyDataType columnName=source, tableName=issue; modifyDataType columnName=sink, tableName=issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_29::hp_main
CREATE INDEX IssueLastScanIdUpdateInd ON issue(projectVersion_id, engineType, id);

DROP INDEX tempInstanceId_Key ON issue;

ALTER TABLE scan_issue_link DROP FOREIGN KEY fk_scan_issue_link_scan;

ALTER TABLE scan_issue_link DROP FOREIGN KEY fk_scan_issue_link_issue;

CREATE INDEX ScanIssueLinkScanIdInd ON scan_issue_link(scan_id);

CREATE INDEX IssueUpdScanStatusRemDateInd ON issue(projectVersion_id, engineType, lastScan_id);

CREATE INDEX IssueUpdateFoundDateInd ON issue(projectVersion_id, engineType, foundDate);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_29', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 199, '8:d409824a14e299a088b0e8f17749f5a5', 'createIndex indexName=IssueLastScanIdUpdateInd, tableName=issue; dropIndex indexName=tempInstanceId_Key, tableName=issue; dropForeignKeyConstraint baseTableName=scan_issue_link, constraintName=fk_scan_issue_link_scan; dropForeignKeyConstraint base...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_30::hp_main
ALTER TABLE iidmigration ADD status VARCHAR(20) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_30', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 201, '8:318cdadf8dc823a337b0b718a72b5b48', 'addColumn tableName=iidmigration', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_31::hp_main
CREATE INDEX IssueCorrelatedUpdInd ON issue(projectVersion_id, id, correlated);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_31', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 203, '8:dbeaf6dee7a6cc9ea5c7b9fdc7b2e0d5', 'createIndex indexName=IssueCorrelatedUpdInd, tableName=issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_32::hp_main
UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.ReportJob' WHERE JOB_NAME='JOB_REPORT';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.ArtifactUploadJob' WHERE JOB_NAME='JOB_ARTIFACTUPLOAD';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.SourceArchiveUploadJob' WHERE JOB_NAME='JOB_SOURCEUPLOAD';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.HistoricalSnapshotJob' WHERE JOB_NAME='JOB_HISTORICALSNAPSHOT';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.runtime.jobs.ReapplyRuntimeApplicationAssignmentRulesJob' WHERE JOB_NAME='JOB_REAPPLYRUNTIMEASSIGNMENT';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.ArtifactDeleteJob' WHERE JOB_NAME='JOB_ARTIFACTDELETE';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.ArtifactPurgeJob' WHERE JOB_NAME='JOB_ARTIFACTPURGE';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.RefreshFilterSetFolderJob' WHERE JOB_NAME='JOB_REFRESHFILTERSETFOLDER';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.RefreshAnalysisTraceJob' WHERE JOB_NAME='JOB_REFRESHANALYSISTRACE';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.AlertReminderJob' WHERE JOB_NAME='AlertReminder';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.LdapCacheRefreshJob' WHERE JOB_NAME='LdapCacheRefresh';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.LdapCacheRefreshJob' WHERE JOB_NAME='JOB_LDAPMANUALREFRESH';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.BatchBugSubmissionJob' WHERE JOB_NAME='JOB_BATCHBUGSUBMISSION';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.BugStateManagementJob' WHERE JOB_NAME='JOB_BUGSTATEMANAGEMENT';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.OrphanedDocInfoCleanupJob' WHERE JOB_NAME='OrphanedDocInfoCleanup';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.ProjectVersionCopyJob' WHERE JOB_NAME='JOB_PROJECTVERSIONCOPY';

UPDATE QRTZ_JOB_DETAILS SET JOB_CLASS_NAME = 'com.fortify.manager.BLL.jobs.ProjectVersionCreateInWIEJob' WHERE JOB_NAME='JOB_PROJECTVERSIONCREATEINWIE';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_32', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 205, '8:26f6209050a746609992eaa0e39e9536', 'update tableName=QRTZ_JOB_DETAILS; update tableName=QRTZ_JOB_DETAILS; update tableName=QRTZ_JOB_DETAILS; update tableName=QRTZ_JOB_DETAILS; update tableName=QRTZ_JOB_DETAILS; update tableName=QRTZ_JOB_DETAILS; update tableName=QRTZ_JOB_DETAILS; up...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.0.0.xml::f360_4.0.0_33::hp_main
CREATE INDEX IssueScanStatusUpdInd ON issue(projectVersion_id, engineType, id, scanStatus, lastScan_id, removedDate);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.0.0_33', 'hp_main', 'dbF360_4.0.0.xml', NOW(), 207, '8:a98f98ab4e60fd1ab84237b1edccfc32', 'createIndex indexName=IssueScanStatusUpdInd, tableName=issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.1.0.xml::f360_4.1.0_1::hp_main
ALTER TABLE sourcefilemap ADD matchingPath VARCHAR(255) NULL;

CREATE INDEX SourceFileScanMatchPathInd ON sourcefilemap(scan_id, matchingPath);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.1.0_1', 'hp_main', 'dbF360_4.1.0.xml', NOW(), 209, '8:75b11a918cb36b8147673f83aec099d1', 'addColumn tableName=sourcefilemap; createIndex indexName=SourceFileScanMatchPathInd, tableName=sourcefilemap', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.1.0.xml::f360_4.1.0_2::hp_main
CREATE INDEX AuditValueAttrGuidValueInd ON auditvalue(attrGuid, attrValue);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.1.0_2', 'hp_main', 'dbF360_4.1.0.xml', NOW(), 211, '8:3d5d9a42760f4a638fe4ff243540afed', 'createIndex indexName=AuditValueAttrGuidValueInd, tableName=auditvalue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.1.0.xml::f360_4.1.0_3::hp
INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.1.0_3', 'hp', 'dbF360_4.1.0.xml', NOW(), 213, '8:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.1.0.xml::f360_4.1.0_4::hp_main
ALTER TABLE finding MODIFY guid VARCHAR(255);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.1.0_4', 'hp_main', 'dbF360_4.1.0.xml', NOW(), 215, '8:264a09197e6b11599cfdbd548260f668', 'modifyDataType columnName=guid, tableName=finding', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.1.0.xml::f360_4.1.0_5::hp_main
ALTER TABLE filterset DROP FOREIGN KEY RefPVFilterSet;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.1.0_5', 'hp_main', 'dbF360_4.1.0.xml', NOW(), 217, '8:a7fc4570aca5c02798f2cb83471edbb0', 'dropForeignKeyConstraint baseTableName=filterset, constraintName=RefPVFilterSet', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.1.0.xml::f360_4.1.0_6::hp_main
DROP INDEX filterset_altkey_1 ON filterset;

delete from filterset where projectVersion_id is null;

ALTER TABLE filterset MODIFY projectVersion_id INT NOT NULL;

CREATE INDEX filterset_altkey_1 ON filterset(projectVersion_id, guid);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.1.0_6', 'hp_main', 'dbF360_4.1.0.xml', NOW(), 219, '8:5ed807f8f0cf9de75b943f0bcb9ec7fb', 'dropIndex indexName=filterset_altkey_1, tableName=filterset; sql; addNotNullConstraint columnName=projectVersion_id, tableName=filterset; createIndex indexName=filterset_altkey_1, tableName=filterset', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.1.0.xml::f360_4.1.0_7::hp_main
ALTER TABLE filterset ADD CONSTRAINT RefPVFilterSet FOREIGN KEY (projectVersion_id) REFERENCES projectversion (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.1.0_7', 'hp_main', 'dbF360_4.1.0.xml', NOW(), 221, '8:cc133bfd2ea4bd3874eacf71044ac165', 'addForeignKeyConstraint baseTableName=filterset, constraintName=RefPVFilterSet, referencedTableName=projectversion', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.1.0.xml::f360_4.1.0_8::hp_main
CREATE TABLE scanerror (id INT AUTO_INCREMENT NOT NULL, scan_id INT NOT NULL, errorCode VARCHAR(20) NULL, errorDescription VARCHAR(4000) NULL, CONSTRAINT ScanErrorPk PRIMARY KEY (id));

ALTER TABLE scanerror ADD CONSTRAINT RefScanErrorToScan FOREIGN KEY (scan_id) REFERENCES scan (id) ON DELETE CASCADE;

CREATE UNIQUE INDEX scanerror_altkey ON scanerror(scan_id, id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.1.0_8', 'hp_main', 'dbF360_4.1.0.xml', NOW(), 223, '8:3d9220ad5fba3d1778a39e8be2208df7', 'createTable tableName=scanerror; addForeignKeyConstraint baseTableName=scanerror, constraintName=RefScanErrorToScan, referencedTableName=scan; createIndex indexName=scanerror_altkey, tableName=scanerror', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.1.0.xml::f360_4.1.0_9::hp_main
ALTER TABLE rulepack ADD locale VARCHAR(2) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.1.0_9', 'hp_main', 'dbF360_4.1.0.xml', NOW(), 225, '8:b521873de955ad21bfd374ecb67900be', 'addColumn tableName=rulepack', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.1.0.xml::f360_4.1.0_11::hp_main
CREATE TABLE reportparameteroption (id INT AUTO_INCREMENT NOT NULL, reportParameter_id INT NULL, value VARCHAR(100) NULL, displayName VARCHAR(255) NULL, `description` VARCHAR(2000) NULL, defaultValue CHAR(1) DEFAULT 'N' NOT NULL, valueorder INT NULL, CONSTRAINT ReportParameterOptionPk PRIMARY KEY (id));

ALTER TABLE reportparameteroption ADD CONSTRAINT ReportParameterOptionFk FOREIGN KEY (reportParameter_id) REFERENCES reportparameter (id) ON DELETE CASCADE;

ALTER TABLE reportparameter MODIFY dataType VARCHAR(30);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.1.0_11', 'hp_main', 'dbF360_4.1.0.xml', NOW(), 227, '8:074e40a591e99a56e2810517e8923dcf', 'createTable tableName=reportparameteroption; addForeignKeyConstraint baseTableName=reportparameteroption, constraintName=ReportParameterOptionFk, referencedTableName=reportparameter; modifyDataType columnName=dataType, tableName=reportparameter', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.1.0.xml::f360_4.1.0_12::hp_main
CREATE INDEX RepParOptionRepParIdKey ON reportparameteroption(reportParameter_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.1.0_12', 'hp_main', 'dbF360_4.1.0.xml', NOW(), 229, '8:a9543cc8b030a63b7f54239da6000655', 'createIndex indexName=RepParOptionRepParIdKey, tableName=reportparameteroption', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.1.0.xml::f360_4.1.0_14::hp_main
DROP INDEX idx_id_table_session_id ON id_table;

DROP TABLE id_table;

CREATE TABLE id_table (session_date BIGINT NOT NULL, session_id INT NOT NULL, id INT NOT NULL);

CREATE INDEX idx_id_table_session_date_id ON id_table(session_date, session_id, id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.1.0_14', 'hp_main', 'dbF360_4.1.0.xml', NOW(), 231, '8:f6cc072bb05aea46534405e67da1f558', 'dropIndex indexName=idx_id_table_session_id, tableName=id_table; dropTable tableName=id_table; createTable tableName=id_table; createIndex indexName=idx_id_table_session_date_id, tableName=id_table', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.1.0.xml::f360_4.1.0_15::hp_main
CREATE TABLE pv_id_table (session_date BIGINT NOT NULL, session_id INT NOT NULL, id INT NOT NULL);

CREATE INDEX idx_pvid_table_session_date_id ON pv_id_table(session_date, session_id, id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.1.0_15', 'hp_main', 'dbF360_4.1.0.xml', NOW(), 233, '8:dc8371f6ea93112e273bf3c263f2fad5', 'createTable tableName=pv_id_table; createIndex indexName=idx_pvid_table_session_date_id, tableName=pv_id_table', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mssql_4.1.0.xml::f360Mssql_4.1.0_0::hp
INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mssql_4.1.0_0', 'hp', 'dbF360Mssql_4.1.0.xml', NOW(), 235, '8:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_1::hp_main
ALTER TABLE scan ADD uploadStatus VARCHAR(20) DEFAULT 'UNPROCESSED' NULL;

UPDATE scan SET uploadStatus = 'PROCESSED';

ALTER TABLE scan MODIFY uploadStatus VARCHAR(20) NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_1', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 237, '8:fe6d21b56388908d214891eb3d258502', 'addColumn tableName=scan; update tableName=scan; addNotNullConstraint columnName=uploadStatus, tableName=scan', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_2::hp_main
ALTER TABLE issuecache DROP PRIMARY KEY;

ALTER TABLE issuecache ADD PRIMARY KEY (projectVersion_id, filterSet_id, issue_id);

ALTER TABLE issuecache MODIFY folder_id INT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_2', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 239, '8:b043e48a9c5a7016c014fff568448428', 'dropPrimaryKey constraintName=PK80, tableName=issuecache; addPrimaryKey constraintName=PK80, tableName=issuecache; dropNotNullConstraint columnName=folder_id, tableName=issuecache', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_3::hp_main
INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_3', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 241, '8:b299de627c965943b551fcb27691715f', 'dropIndex indexName=idx_scanissue_pvid_engine, tableName=scan_issue', '', 'MARK_RAN', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_4::hp_main
DROP INDEX analysisblob_pvid_iid ON analysisblob;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_4', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 243, '8:984c126fa3550d7554941b6ae124709e', 'dropIndex indexName=analysisblob_pvid_iid, tableName=analysisblob', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_5::hp_main
DROP INDEX ScanIssueLinkScanIdInd ON scan_issue_link;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_5', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 245, '8:a626c28196bab90616c8b34d8dead77f', 'dropIndex indexName=ScanIssueLinkScanIdInd, tableName=scan_issue_link', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_6a::hp_main
DROP INDEX scanissueidkey ON scan_issue;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_6a', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 247, '8:9e14f2208bd9f161239fce50a0ce21d5', 'dropIndex indexName=scanissueidkey, tableName=scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_6b::hp_main
CREATE INDEX IX_scanissue_issue ON scan_issue(scan_id, issue_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_6b', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 249, '8:535721cd289cbc19c9ac92bd89c2599c', 'createIndex indexName=IX_scanissue_issue, tableName=scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_7::hp_main
CREATE INDEX IX_issuecache_hidden ON issuecache(filterSet_id, projectVersion_id, hidden);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_7', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 251, '8:fb292817c5693f575c3ef0501801597b', 'createIndex indexName=IX_issuecache_hidden, tableName=issuecache', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_8a::hp_main
DROP INDEX issue_summary_idx ON issue;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_8a', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 253, '8:d68e9b3e159769e108125a5a29f1f9c4', 'dropIndex indexName=issue_summary_idx, tableName=issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_8b::hp_main
CREATE INDEX IX_issue_visibilityAndStatus ON issue(projectVersion_id, suppressed, hidden, scanStatus);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_8b', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 255, '8:a10f31476832215f96822139c816ecab', 'createIndex indexName=IX_issue_visibilityAndStatus, tableName=issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_9::hp_main
CREATE UNIQUE INDEX scanissue_alt_key ON scan_issue(scan_id, issueInstanceId);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_9', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 257, '8:fcf456be2bd858f22bdd1e98915a572a', 'createIndex indexName=scanissue_alt_key, tableName=scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0.10::hp_main
ALTER TABLE issue ADD minVirtualCallConfidence FLOAT DEFAULT 1 NOT NULL;

ALTER TABLE scan_issue ADD minVirtualCallConfidence FLOAT DEFAULT 1 NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0.10', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 259, '8:f38862c420d00e01cc09481ccfc94fc1', 'addColumn tableName=issue; addColumn tableName=scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0.11::hp_main
UPDATE permissiontemplate SET allApplicationRole = 'Y' WHERE guid='admin';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0.11', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 261, '8:c4dd13cca2ca11d606425f7074e11f71', 'update tableName=permissiontemplate', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_12::hp_main
ALTER TABLE projecttemplate ADD obsolete VARCHAR(1) DEFAULT 'N' NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_12', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 263, '8:4caf9cc049140f5be0bbf88df65c3553', 'addColumn tableName=projecttemplate', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_12b::hp_main
UPDATE projecttemplate SET obsolete = 'Y' WHERE guid in (
	'Classic-Priority_Project-Template',
	'Fortify-LowRisk-Project-Template',
	'Fortify-LowRisk3rdParty-Project-Template',
	'Fortify-HighRisk-Project-Template'
);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_12b', 'hp_main', 'dbF360_4.2.0.xml', NOW(), 265, '8:e4a6a058f711d0362c8b4f9efafc79ad', 'update tableName=projecttemplate', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_13::hp_spyglass
DROP TABLE dynamicassessment;

DROP TABLE assessmentsite;

DROP TABLE payloadentry;

DROP TABLE payloadmessage;

DROP TABLE payloadartifact;

DROP TABLE publishaction;

DROP TABLE publishedreport;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_13', 'hp_spyglass', 'dbF360_4.2.0.xml', NOW(), 267, '8:516fb4831fe3e957a09dfd77c91e33ab', 'dropTable tableName=dynamicassessment; dropTable tableName=assessmentsite; dropTable tableName=payloadentry; dropTable tableName=payloadmessage; dropTable tableName=payloadartifact; dropTable tableName=publishaction; dropTable tableName=publishedr...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_14::hp_spyglass
ALTER TABLE project ADD projectTemplate_id INT NULL;

ALTER TABLE project ADD CONSTRAINT RefProjectProjTemplate FOREIGN KEY (projectTemplate_id) REFERENCES projecttemplate (id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_14', 'hp_spyglass', 'dbF360_4.2.0.xml', NOW(), 269, '8:71a0e17b5506aa3767bd20d5d21c0ba6', 'addColumn tableName=project; addForeignKeyConstraint baseTableName=project, constraintName=RefProjectProjTemplate, referencedTableName=projecttemplate', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_15::hp_spyglass
CREATE TABLE project_user (project_id INT NOT NULL, userName VARCHAR(255) NOT NULL, CONSTRAINT PK_PROJECT_USER PRIMARY KEY (project_id, userName)) engine innodb;

CREATE TABLE projectpersonaassignment (project_id INT NOT NULL, persona_id INT NOT NULL, userName VARCHAR(255) NOT NULL, CONSTRAINT PK_PROJECTPERSONAASSIGNMENT PRIMARY KEY (project_id, persona_id)) engine innodb;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_15', 'hp_spyglass', 'dbF360_4.2.0.xml', NOW(), 271, '8:d12876a17780ec5c6cabda3f2364ffd6', 'createTable tableName=project_user; createTable tableName=projectpersonaassignment', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_16::hp_spyglass
ALTER TABLE project_user ADD CONSTRAINT RefProjectUserProject FOREIGN KEY (project_id) REFERENCES project (id) ON DELETE CASCADE;

ALTER TABLE projectpersonaassignment ADD CONSTRAINT RefPPAProject FOREIGN KEY (project_id) REFERENCES project (id) ON DELETE CASCADE;

ALTER TABLE projectpersonaassignment ADD CONSTRAINT RefPPAPersona FOREIGN KEY (persona_id) REFERENCES persona (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_16', 'hp_spyglass', 'dbF360_4.2.0.xml', NOW(), 273, '8:1ec84510ddeeca46114f4b6a49ecdc9a', 'addForeignKeyConstraint baseTableName=project_user, constraintName=RefProjectUserProject, referencedTableName=project; addForeignKeyConstraint baseTableName=projectpersonaassignment, constraintName=RefPPAProject, referencedTableName=project; addFo...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_17::hp_spyglass
CREATE TABLE metavalueproject (id INT AUTO_INCREMENT NOT NULL, metaDef_id INT NOT NULL, textValue VARCHAR(2000) NULL, booleanValue CHAR(1) NULL, objectVersion INT NULL, dateValue date NULL, integerValue BIGINT NULL, project_id INT NOT NULL, CONSTRAINT MetaValueProjectPk PRIMARY KEY (id)) engine innodb;

CREATE TABLE metavalueselectionproject (projectMetaValue_id INT NOT NULL, metaOption_id INT NOT NULL, CONSTRAINT MetaValueSelectionProjectPk PRIMARY KEY (projectMetaValue_id, metaOption_id)) engine innodb;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_17', 'hp_spyglass', 'dbF360_4.2.0.xml', NOW(), 275, '8:0833d1c2d4df39db19dc192756936170', 'createTable tableName=metavalueproject; createTable tableName=metavalueselectionproject', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_18::hp_spyglass
ALTER TABLE metavalueproject ADD CONSTRAINT RefMetaDefProjMVUniq UNIQUE (metaDef_id, project_id);

ALTER TABLE metavalueproject ADD CONSTRAINT RefMetaValProj FOREIGN KEY (project_id) REFERENCES project (id) ON DELETE CASCADE;

ALTER TABLE metavalueproject ADD CONSTRAINT RefMetaValProjMetaDef FOREIGN KEY (metaDef_id) REFERENCES metadef (id) ON DELETE CASCADE;

ALTER TABLE metavalueselectionproject ADD CONSTRAINT RefMVProjSelMVProj FOREIGN KEY (projectMetaValue_id) REFERENCES metavalueproject (id);

ALTER TABLE metavalueselectionproject ADD CONSTRAINT RefMVProjSelMVOption FOREIGN KEY (metaOption_id) REFERENCES metaoption (id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_18', 'hp_spyglass', 'dbF360_4.2.0.xml', NOW(), 277, '8:f1edcf6e51fc9bcba9f239901b277758', 'addUniqueConstraint constraintName=RefMetaDefProjMVUniq, tableName=metavalueproject; addForeignKeyConstraint baseTableName=metavalueproject, constraintName=RefMetaValProj, referencedTableName=project; addForeignKeyConstraint baseTableName=metavalu...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0.xml::f360_4.2.0_19::hp_spyglass
CREATE INDEX idx_variable_name ON variable(name);

ALTER TABLE projectversion ADD latestSnapshot_id INT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_19', 'hp_spyglass', 'dbF360_4.2.0.xml', NOW(), 279, '8:20304c79776fad17a34fc03fd24e033a', 'createIndex indexName=idx_variable_name, tableName=variable; addColumn tableName=projectversion', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0_config.xml::f360_4.2.0_config_1::hp
CREATE TABLE configproperty (groupName VARCHAR(100) NULL, propertyName VARCHAR(128) NULL, propertyValue VARCHAR(1024) NULL, objectVersion INT DEFAULT 1 NULL, `description` VARCHAR(2048) NULL, appliedAfterRestarting VARCHAR(1) DEFAULT 'Y' NULL, propertyType VARCHAR(15) DEFAULT 'STRING' NOT NULL, valuesList VARCHAR(4000) NULL, groupSwitch VARCHAR(1) DEFAULT 'N' NULL);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_config_1', 'hp', 'dbF360_4.2.0_config.xml', NOW(), 281, '8:024b73b02ff5796778d26291bbca974e', 'createTable tableName=configproperty', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0_config.xml::f360_4.2.0_config_2::hp
INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('core', 'relative.session.timeout.minutes', '30', 'Inactive Session Timeout (minutes)', 'INTEGER');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('core', 'absolute.session.timeout.minutes', '240', 'Absolute Session Timeout (minutes)', 'INTEGER');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('core', 'authentication.max_failed_login_attempts', '3', 'Login Attempts before Lockout', 'INTEGER');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('core', 'authentication.days_password_valid', '30', 'Days before password reset', 'INTEGER');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('core', 'authentication.minutes_user_frozen', '30', 'Lockout time (minutes)', 'INTEGER');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('core', 'rulepack.update.url', 'https://update.fortify.com', 'Rulepack Update URL', 'URL');

INSERT INTO configproperty (groupName, propertyName, `description`) VALUES ('core', 'rulepack.update.proxy.host', 'Proxy for Rulepack Update');

INSERT INTO configproperty (groupName, propertyName, `description`, propertyType) VALUES ('core', 'rulepack.update.proxy.port', 'Proxy Port', 'INTEGER');

INSERT INTO configproperty (groupName, propertyName, `description`) VALUES ('core', 'rulepack.update.proxy.username', 'Proxy Username');

INSERT INTO configproperty (groupName, propertyName, `description`, propertyType) VALUES ('core', 'rulepack.update.proxy.password', 'Proxy Password', 'ENCODEDHIDDEN');

INSERT INTO configproperty (groupName, propertyName, `description`) VALUES ('core', 'rulepack.update.locale', 'Locale for Rulepacks');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('core', 'events.to.issues.max.events', '5', 'Maximum Events Per Security Scope Issue (the maximum number of events to store in the details of an issue when converting events to issues)', 'INTEGER');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('core', 'runtime.event.description.url', 'https://content.fortify.com/products/360/rta/descriptions/', 'Base URL for Runtime Event description server (it''s also used when converting events to issues)', 'URL');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('core', 'display.user.details', 'true', 'Display user first/last names and e-mails in user fields, along with login names', 'BOOLEAN');

INSERT INTO configproperty (groupName, propertyName, `description`, propertyType) VALUES ('core', 'user.administrator.email', 'User Administrator''s Email Address (for user account requests)', 'EMAIL');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, groupSwitch) VALUES ('cas', 'cas.enabled', 'false', 'Enable CAS Integration', 'BOOLEAN', 'Y');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('cas', 'cas.server.url', 'http://localhost:8080/cas', 'CAS Server URL', 'URL');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('cas', 'cas.f360.server.location', 'http://localhost:8180/ssc', 'HP Software Security Center Location', 'URL');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('cloudscan', 'cloud.ctrl.url', 'http://localhost:8080/scancentral-ctrl', 'CloudScan Controller URL', 'URL');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('cloudscan', 'cloud.ctrl.poll.enabled', 'false', 'CloudCtrl status polling enablement', 'BOOLEAN');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('cloudscan', 'cloud.ctrl.poll.period', '120', 'CloudCtrl polling period (seconds)', 'INTEGER');

INSERT INTO configproperty (groupName, propertyName, `description`) VALUES ('cloudscan', 'ssc.cloud.ctrl.secret', 'SSC and CloudScan Controller Shared Secret');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, groupSwitch) VALUES ('email', 'email.enabled', 'false', 'Enable Email for sending alerts', 'BOOLEAN', 'Y');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`) VALUES ('email', 'email.server', 'mail.example.com', 'SMTP Server');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('email', 'email.server.port', '25', 'SMTP Server Port', 'INTEGER');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('email', 'email.addr.from', 'fortifyserver@example.com', 'From e-mail address', 'EMAIL');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('email', 'email.server.username', 'AGAbY6O1qDV4p7lhkklU0S/k7O46SrqvJGAEUBsfus8h', 'SMTP username', 'ENCODED');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('email', 'email.server.password', 'AGAbY6O1qDV4p7lhkklU0S/k7O46SrqvJGAEUBsfus8h', 'SMTP password', 'ENCODEDHIDDEN');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`) VALUES ('email', 'email.default.encoding', 'UTF-8', 'Default encoding of the email content');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, groupSwitch) VALUES ('jms', 'jms.publish.events', 'false', 'Publish System Events to JMS', 'BOOLEAN', 'Y');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('jms', 'jms.include.username', 'true', 'Include username in JMS body', 'BOOLEAN');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`) VALUES ('jms', 'jms.topic', 'Fortify.Advisory.EventNotification', 'JMS Topic');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`) VALUES ('jms', 'jms.broker.url', 'tcp://127.0.0.1:61616', 'JMS Server URL');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`) VALUES ('scheduler', 'snapshot.daysOfWeek', '*', 'a comma-separated list of the daysOfWeek for the historical collection job to run.  * means run every day.  1 means Sunday, 2 means Monday, etc');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`) VALUES ('scheduler', 'snapshot.hours', '0', 'a comma-separated list of the hours of the day for the historical collection job to run.  * means run every hour.');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`) VALUES ('scheduler', 'snapshot.minutes', '0', 'a comma-separated list of the minutes of each hour for the historical collection job to run.  Do not run more than once every 5 minutes.');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, groupSwitch) VALUES ('runtime', 'runtime.federation.enabled', 'false', 'Enable Runtime', 'BOOLEAN', 'Y');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('runtime', 'runtime.port', '10234', 'Port for Runtime federation', 'INTEGER');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`) VALUES ('runtime', 'rtcontroller.sysadmin.email.addresses', 'noone@example.com', 'Email addresses (comma separated) to notify when a runtime configuration errors occurs');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('runtime', 'runtime.strict.certificate.checking', 'true', 'Enforce strice sertificate checking', 'BOOLEAN');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, groupSwitch) VALUES ('sso', 'sso.enabled', 'false', 'Enable SSO Integration. WARNING: Single-Sign-On should only be enabled for a locked-down HP Fortify Software Security Center instance, with Apache Agent capable of SSO authentication in front. The SSO-enabled Apache Agent should pass trusted HTTP headers to SSC. For more information, please refer to HP Fortify Software Security Center Deployment Guide', 'BOOLEAN', 'Y');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`) VALUES ('sso', 'sso.header.username', 'username', 'HTTP Header for Username. NOTE: that the sso_header_username must always be used to retrieve the username from the SSO headers and this value must match the ldap.attribute.username property in ldap.properties');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('webservices', 'allow.token.authentication', 'true', 'Allow Token Authentication', 'BOOLEAN');

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_config_2', 'hp', 'dbF360_4.2.0_config.xml', NOW(), 283, '8:efe5ea21793db55ddf9d4de2cbfc8236', 'insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0_config.xml::f360_4.2.0_config_3::hp
CREATE UNIQUE INDEX idx_configproperty_group_prop ON configproperty(groupName, propertyName);

CREATE UNIQUE INDEX idx_configproperty_propName ON configproperty(propertyName);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_config_3', 'hp', 'dbF360_4.2.0_config.xml', NOW(), 285, '8:a1d38c135a6aedc3318ec9b66f44e858', 'createIndex indexName=idx_configproperty_group_prop, tableName=configproperty; createIndex indexName=idx_configproperty_propName, tableName=configproperty', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.2.0_config.xml::f360_4.2.0_config_4::hp
CREATE TABLE applicationstate (id INT NOT NULL, restartRequired VARCHAR(1) DEFAULT 'N' NULL, configVisitRequired VARCHAR(1) DEFAULT 'Y' NULL, CONSTRAINT PK_APPLICATIONSTATE PRIMARY KEY (id));

INSERT INTO applicationstate (id, restartRequired, configVisitRequired) VALUES (1, 'N', 'Y');

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.2.0_config_4', 'hp', 'dbF360_4.2.0_config.xml', NOW(), 287, '8:1aef687c5f4740deda62a07689c7d533', 'createTable tableName=applicationstate; insert tableName=applicationstate', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_4.2.0.xml::f360Mysql_4.2.0_0::hp
ALTER TABLE `issue` ROW_FORMAT=DYNAMIC;

ALTER TABLE `scan_issue` ROW_FORMAT=DYNAMIC;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_4.2.0_0', 'hp', 'dbF360Mysql_4.2.0.xml', NOW(), 289, '8:dc1d279ce5ef914b3cfc9ee71f72dd25', 'sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_1::hp_main
UPDATE QRTZ_JOB_DETAILS SET REQUESTS_RECOVERY = '1' WHERE JOB_NAME = 'JOB_HISTORICALSNAPSHOT' AND JOB_GROUP = 'JOBGROUP_HISTORICALSNAPSHOT';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_1', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 291, '8:a2beca6d322b120790f6ea939fadd753', 'update tableName=QRTZ_JOB_DETAILS', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_2::hp_main
CREATE TABLE project_ldapentity (project_id INT NOT NULL, ldap_id INT NOT NULL, CONSTRAINT PK_PROJECT_LDAPENTITY PRIMARY KEY (project_id, ldap_id)) engine innodb;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_2', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 293, '8:e108b23aa29be860a0ac030dca2f949e', 'createTable tableName=project_ldapentity', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_20::hp_main
CREATE TABLE jobqueue (jobName VARCHAR(255) NOT NULL, jobGroup VARCHAR(255) NOT NULL, jobClassName VARCHAR(128) NOT NULL, projectVersion_id BIGINT NULL, artifact_id BIGINT NULL, userName VARCHAR(255) NULL, state INT NULL, executionOrder DECIMAL(31, 8) NOT NULL, jobData MEDIUMBLOB NULL, startTime timestamp NULL, finishTime timestamp NULL, CONSTRAINT PK_JOBQUEUE PRIMARY KEY (jobName), CONSTRAINT UQ_EXECUTIONORDER UNIQUE (executionOrder));

CREATE INDEX JOBGROUP_STATE_IDX ON jobqueue(jobGroup, state);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_20', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 295, '8:858b3f9281398c7971cb65d25389f69a', 'createTable tableName=jobqueue; createIndex indexName=JOBGROUP_STATE_IDX, tableName=jobqueue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_21::hp_main
INSERT INTO configproperty (groupName, propertyName, propertyValue, propertyType, `description`) VALUES ('scheduler', 'job.cleanExecutedAfter.days', '1', 'INTEGER', 'Number of days after which executed jobs will be removed');

INSERT INTO configproperty (groupName, propertyName, propertyValue, valuesList, propertyType, `description`) VALUES ('scheduler', 'job.executionStrategy.class', 'com.fortify.manager.service.scheduler.SchedulerConservativeStrategy', 'Conservative|||||com.fortify.manager.service.scheduler.SchedulerConservativeStrategy-----Aggressive|||||com.fortify.manager.service.scheduler.SchedulerAggressiveStrategy-----Exclusive jobs|||||com.fortify.manager.service.scheduler.SchedulerExclusiveJobsStrategy', 'OPTIONLIST', 'Job execution strategy');

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_21', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 297, '8:cebbcfdaf8b8603b57b3c8ec78734879', 'insert tableName=configproperty; insert tableName=configproperty', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_22::hp_main
DELETE FROM QRTZ_CRON_TRIGGERS WHERE TRIGGER_GROUP='JOBGROUP_HISTORICALSNAPSHOT';

DELETE FROM QRTZ_CRON_TRIGGERS WHERE TRIGGER_GROUP='DEFAULT' AND TRIGGER_NAME IN ('alertReminderTrigger',
				'idTableCleanupTrigger',
				'ldapCacheRefreshTrigger',
				'orphanedDocInfoCleanupTrigger');

DELETE FROM QRTZ_TRIGGERS WHERE TRIGGER_GROUP='JOBGROUP_HISTORICALSNAPSHOT' AND TRIGGER_TYPE='CRON';

DELETE FROM QRTZ_TRIGGERS WHERE TRIGGER_GROUP='DEFAULT' AND TRIGGER_NAME IN ('alertReminderTrigger',
				'idTableCleanupTrigger',
				'ldapCacheRefreshTrigger',
				'orphanedDocInfoCleanupTrigger');

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_22', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 299, '8:d228b95db0d8f198625cdbdf23a00b09', 'delete tableName=QRTZ_CRON_TRIGGERS; delete tableName=QRTZ_CRON_TRIGGERS; delete tableName=QRTZ_TRIGGERS; delete tableName=QRTZ_TRIGGERS', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_23::hp_main
CREATE INDEX MONITORED_INSTANCE_ID_IDX ON alert(monitoredInstanceId, monitoredEntityType);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_23', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 301, '8:fce2ed9584b3fdcd64cabffa25952713', 'createIndex indexName=MONITORED_INSTANCE_ID_IDX, tableName=alert', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_24::hp_main
CREATE INDEX METAVALUE_METADEF_ID_IDX ON metavalue(metaDef_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_24', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 303, '8:9783e105b23d3fc3c4f9864e4c94ec0d', 'createIndex indexName=METAVALUE_METADEF_ID_IDX, tableName=metavalue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_25::hp_main
CREATE TABLE snapshotquickvalues (snapshot_id INT NOT NULL, issues INT NOT NULL, cfpo INT NOT NULL, hfpo INT NOT NULL, mfpo INT NOT NULL, lfpo INT NOT NULL, cfpoAudited INT NOT NULL, hfpoAudited INT NOT NULL, mfpoAudited INT NOT NULL, lfpoAudited INT NOT NULL, cfpoUnaudited INT NOT NULL, hfpoUnaudited INT NOT NULL, mfpoUnaudited INT NOT NULL, lfpoUnaudited INT NOT NULL, CONSTRAINT PK_SNAPSHOTQUICKVALUES PRIMARY KEY (snapshot_id));

ALTER TABLE snapshotquickvalues ADD CONSTRAINT RefQuickValuesSnapshot FOREIGN KEY (snapshot_id) REFERENCES snapshot (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_25', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 305, '8:d4648285333a89c73766176ead5dd482', 'createTable tableName=snapshotquickvalues; addForeignKeyConstraint baseTableName=snapshotquickvalues, constraintName=RefQuickValuesSnapshot, referencedTableName=snapshot', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_26::hp_main
ALTER TABLE projectversion ADD status VARCHAR(20) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_26', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 307, '8:32d09429e7b0c37853abdf37984b40fc', 'addColumn tableName=projectversion', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_27::hp_main
UPDATE configproperty SET propertyType = 'URL' WHERE propertyName = 'jms.broker.url';

UPDATE configproperty SET propertyType = 'HOSTNAME' WHERE propertyName = 'rulepack.update.proxy.host';

UPDATE configproperty SET propertyType = 'MULTI_EMAIL' WHERE propertyName = 'rtcontroller.sysadmin.email.addresses';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_27', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 309, '8:53450ce43810c6bd91c71ee4f638955d', 'update tableName=configproperty; update tableName=configproperty; update tableName=configproperty', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_28::hp_main
CREATE INDEX AB_PV_ISSUEINSTANCE_IDX ON analysisblob(projectVersion_id, issueInstanceId);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_28', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 311, '8:07d92a0f2fa1b2a5024a5f156ba8fa0b', 'createIndex indexName=AB_PV_ISSUEINSTANCE_IDX, tableName=analysisblob', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_30::hp_main
DROP INDEX IX_issue_folder_update ON issue;

DROP INDEX IX_issuecache_hidden ON issuecache;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_30', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 313, '8:b28ec22cf925ed973de6c00e29c56a93', 'dropIndex indexName=IX_issue_folder_update, tableName=issue; dropIndex indexName=IX_issuecache_hidden, tableName=issuecache', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_31::hp_main
DROP INDEX IssueAltKeyWithEngineType ON issue;

DROP INDEX IssueCorrelatedUpdInd ON issue;

DROP INDEX IssueEngineStatusAltKey ON issue;

DROP INDEX IssueLastScanIdUpdateInd ON issue;

DROP INDEX IssueProjLastScanAltKey ON issue;

DROP INDEX IssueScanStatusUpdInd ON issue;

DROP INDEX IssueUpdateFoundDateInd ON issue;

DROP INDEX IssueUpdScanStatusRemDateInd ON issue;

DROP INDEX Issue_Alt_Key ON issue;

DROP INDEX issue_mappedCategory_idx ON issue;

DROP INDEX IX_issue_conf_sev ON issue;

DROP INDEX IX_issue_removeddate ON issue;

DROP INDEX IX_issue_visibilityAndStatus ON issue;

CREATE INDEX PV_SCAN_IDX ON issue(projectVersion_id, engineType, lastScan_id, scanStatus);

CREATE INDEX PV_CATEGORY_IDX ON issue(projectVersion_id, mappedCategory, suppressed, scanStatus);

CREATE INDEX PV_SEVERITY_IDX ON issue(projectVersion_id, severity, audienceSet, confidence);

CREATE INDEX PV_IMPACT_IDX ON issue(projectVersion_id, impact, likelihood, suppressed, scanStatus);

CREATE INDEX PV_FRIORITY_IDX ON issue(projectVersion_id, friority, suppressed, scanStatus);

CREATE INDEX BUG_IDX ON issue(bug_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_31', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 315, '8:6152a556dbf80c589551d387b61d8433', 'dropIndex indexName=IssueAltKeyWithEngineType, tableName=issue; dropIndex indexName=IssueCorrelatedUpdInd, tableName=issue; dropIndex indexName=IssueEngineStatusAltKey, tableName=issue; dropIndex indexName=IssueLastScanIdUpdateInd, tableName=issue...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_32::hp_main
CREATE INDEX PV_STATE_IDX ON issue(projectVersion_id, issueState, suppressed, scanStatus);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_32', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 317, '8:9b877cb0021b790827d61ab1eb1bf194', 'createIndex indexName=PV_STATE_IDX, tableName=issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_33::hp_main
CREATE INDEX CPEC_NAME_IDX ON catpackexternalcategory(catPackExternalList_id, name, id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_33', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 319, '8:293a4d9f739c6856ee19f917d8ef6421', 'createIndex indexName=CPEC_NAME_IDX, tableName=catpackexternalcategory', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_34::hp_main
CREATE INDEX SCAN_PV_IDX ON scan_issue(scan_id, projectVersion_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_34', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 321, '8:f4e4d1f6f8ede5b05ecf0556271e115c', 'createIndex indexName=SCAN_PV_IDX, tableName=scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_35::hp_main
CREATE INDEX PV_ID_IDX ON issue(projectVersion_id, id, friority);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_35', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 323, '8:54e19d372bfe3c76a101319a2e5aa942', 'createIndex indexName=PV_ID_IDX, tableName=issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_37::hp_main
ALTER TABLE auditvalue DROP FOREIGN KEY RefIssAuditVal;

ALTER TABLE audithistory DROP FOREIGN KEY RefIssAuditHis;

ALTER TABLE auditcomment DROP FOREIGN KEY RefIssAuditComment;

ALTER TABLE issuecache DROP FOREIGN KEY fk_issuecache_issue;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_37', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 325, '8:31eee4bce87d21dd90a6350c7828dca4', 'dropForeignKeyConstraint baseTableName=auditvalue, constraintName=RefIssAuditVal; dropForeignKeyConstraint baseTableName=audithistory, constraintName=RefIssAuditHis; dropForeignKeyConstraint baseTableName=auditcomment, constraintName=RefIssAuditCo...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_39::hp_main
ALTER TABLE scan_issue MODIFY vulnerableParameter VARCHAR(200);

ALTER TABLE issue MODIFY vulnerableParameter VARCHAR(200);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_39', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 327, '8:80391abe291b4edca59ec9a68d271f6b', 'modifyDataType columnName=vulnerableParameter, tableName=scan_issue; modifyDataType columnName=vulnerableParameter, tableName=issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.0.xml::f360_4.3.0_40::hp_main
ALTER TABLE metadef ADD systemUsage VARCHAR(50) NULL;

UPDATE metadef SET systemUsage = 'USER_DEFINED_DELETABLE' WHERE systemUsage IS NULL;

ALTER TABLE metadef MODIFY systemUsage VARCHAR(50) NOT NULL;

ALTER TABLE metadef ALTER systemUsage SET DEFAULT 'USER_DEFINED_DELETABLE';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.0_40', 'hp_main', 'dbF360_4.3.0.xml', NOW(), 329, '8:5bff51c0828410f20b561d4db6efeee7', 'addColumn tableName=metadef; addNotNullConstraint columnName=systemUsage, tableName=metadef; addDefaultValue columnName=systemUsage, tableName=metadef', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_4.3.0.xml::f360Mysql_4.3.0_0::hp_main
ALTER TABLE `hostlogmessage` ADD `msg_new` TEXT;

UPDATE hostlogmessage set msg_new = msg;

ALTER TABLE `hostlogmessage` DROP COLUMN `msg`;

ALTER TABLE `hostlogmessage` CHANGE `msg_new` `msg` TEXT;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_4.3.0_0', 'hp_main', 'dbF360Mysql_4.3.0.xml', NOW(), 331, '8:a454dd5b06bd514a875c6b4b7732e11f', 'sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_4.3.0.xml::f360Mysql_4.3.0_1::hp_main
DROP INDEX ISSUE_BUG_IND ON issue;

DROP INDEX catPackExtCatNameExtListId_idx ON catpackexternalcategory;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_4.3.0_1', 'hp_main', 'dbF360Mysql_4.3.0.xml', NOW(), 333, '8:13b67774783b3fa2b82d3374b2f10ccf', 'dropIndex indexName=ISSUE_BUG_IND, tableName=issue; dropIndex indexName=catPackExtCatNameExtListId_idx, tableName=catpackexternalcategory', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_4.3.0.xml::f360Mysql_4.3.0_2::hp_main
CREATE UNIQUE INDEX PV_ISSUEINSTANCE_IDX ON issue(projectVersion_id, issueInstanceId, engineType);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_4.3.0_2', 'hp_main', 'dbF360Mysql_4.3.0.xml', NOW(), 335, '8:3a3bb9f3fcc7b714f847951ba022a0f9', 'createIndex indexName=PV_ISSUEINSTANCE_IDX, tableName=issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.1.xml::f360_4.3.1_1::hp
--  Add column for ordering configuration properties
ALTER TABLE configproperty ADD propertyOrder INT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.1_1', 'hp', 'dbF360_4.3.1.xml', NOW(), 337, '8:c464cde4f6edac8684eb418bdd369178', 'addColumn tableName=configproperty', 'Add column for ordering configuration properties', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.1.xml::f360_4.3.1_2::hp
CREATE TABLE reportexecparam (paramType VARCHAR(8) NOT NULL, paramKey VARCHAR(255) NOT NULL, paramValue VARCHAR(2000) NULL);

CREATE TABLE reportexecblob (blobType VARCHAR(8) NOT NULL, originalFilename VARCHAR(255) NOT NULL, data MEDIUMBLOB NULL);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.1_2', 'hp', 'dbF360_4.3.1.xml', NOW(), 339, '8:e1555457f2eb0f2b04026368984227d3', 'createTable tableName=reportexecparam; createTable tableName=reportexecblob', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.1.xml::f360_4.3.1_4::hp
ALTER TABLE reportexecparam ADD savedReport_id INT DEFAULT 0 NOT NULL;

ALTER TABLE reportexecblob ADD savedReport_id INT DEFAULT 0 NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.1_4', 'hp', 'dbF360_4.3.1.xml', NOW(), 341, '8:ae39f028e1df5a26f86aeb627b67bef2', 'addColumn tableName=reportexecparam; addColumn tableName=reportexecblob', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.1.xml::f360_4.3.1_5::hp
ALTER TABLE reportexecparam ADD PRIMARY KEY (savedReport_id, paramKey);

ALTER TABLE reportexecblob ADD PRIMARY KEY (savedReport_id, originalFilename);

ALTER TABLE reportexecblob ADD CONSTRAINT RefReportExecBlobSavedReport FOREIGN KEY (savedReport_id) REFERENCES savedreport (id) ON DELETE CASCADE;

ALTER TABLE reportexecparam ADD CONSTRAINT RefReportExecParamSavedReport FOREIGN KEY (savedReport_id) REFERENCES savedreport (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.1_5', 'hp', 'dbF360_4.3.1.xml', NOW(), 343, '8:2f596d5dbbcda9abf88ed9311551176d', 'addPrimaryKey tableName=reportexecparam; addPrimaryKey tableName=reportexecblob; addForeignKeyConstraint baseTableName=reportexecblob, constraintName=RefReportExecBlobSavedReport, referencedTableName=savedreport; addForeignKeyConstraint baseTableN...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.3.1.xml::f360_4.3.1_6::hp
INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, appliedAfterRestarting, propertyOrder) VALUES ('birt.report', 'birt.report.enhancedSecurity.enabled', 'false', 'Enhanced security', 'BOOLEAN', 'N', 10);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, appliedAfterRestarting, propertyOrder) VALUES ('birt.report', 'birt.report.username', '', 'Username', 'STRING', 'N', 20);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, appliedAfterRestarting, propertyOrder) VALUES ('birt.report', 'birt.report.password', '', 'Password', 'ENCODEDHIDDEN', 'N', 30);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, appliedAfterRestarting, propertyOrder) VALUES ('birt.report', 'birt.report.maxHeapSize', '3072', 'Maximum heap size (MB)', 'INTEGER', 'N', 40);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, appliedAfterRestarting, propertyOrder) VALUES ('birt.report', 'birt.report.timeout', '1440', 'Execution timeout (minutes)', 'INTEGER', 'N', 50);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.3.1_6', 'hp', 'dbF360_4.3.1.xml', NOW(), 345, '8:81e2f04b2bb59faa0b7e392c4c53a432', 'insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_0::hp
--  Solves index creation issues for MySQL utf8_bin collation. MUST RUN BEFORE sourcefilemap CHANGES
ALTER TABLE `sourcefilemap` ROW_FORMAT=DYNAMIC;

ALTER TABLE `finding` ROW_FORMAT=DYNAMIC;

ALTER TABLE `scan_finding` ROW_FORMAT=DYNAMIC;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_0', 'hp', 'dbF360_4.4.0.xml', NOW(), 347, '8:cd6524475abcf65d6342636fc7aa2afd', 'sql', 'Solves index creation issues for MySQL utf8_bin collation. MUST RUN BEFORE sourcefilemap CHANGES', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_1::hp
ALTER TABLE sourcefilemap ADD fileName VARCHAR(500) NULL;

CREATE INDEX SourceFileMapScanIdFileNameInd ON sourcefilemap(scan_id, fileName);

ALTER TABLE sourcefilemap DROP PRIMARY KEY;

ALTER TABLE sourcefilemap MODIFY filePath VARCHAR(3000);

DROP INDEX SourceFileScanMatchPathInd ON sourcefilemap;

ALTER TABLE sourcefilemap DROP COLUMN matchingPath;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_1', 'hp', 'dbF360_4.4.0.xml', NOW(), 349, '8:af38da7fca1a14ba946083de2ce0d0d3', 'addColumn tableName=sourcefilemap; createIndex indexName=SourceFileMapScanIdFileNameInd, tableName=sourcefilemap; dropPrimaryKey tableName=sourcefilemap; modifyDataType columnName=filePath, tableName=sourcefilemap; dropIndex indexName=SourceFileSc...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_4.4.0_sourcefilemap_id.xml::f360Mysql_4.4.0_0::hp
alter table sourcefilemap add id Int NOT NULL AUTO_INCREMENT primary key;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_4.4.0_0', 'hp', 'dbF360Mysql_4.4.0_sourcefilemap_id.xml', NOW(), 351, '8:70e451d0bd56719282f49af5da6ddd5e', 'sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_2::hp
ALTER TABLE issue MODIFY fileName VARCHAR(3000);

ALTER TABLE scan_issue MODIFY fileName VARCHAR(3000);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_2', 'hp', 'dbF360_4.4.0.xml', NOW(), 353, '8:5b8474f73fafd069fc9091c883924427', 'modifyDataType columnName=fileName, tableName=issue; modifyDataType columnName=fileName, tableName=scan_issue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_3::hp
ALTER TABLE finding MODIFY guid VARCHAR(512);

ALTER TABLE scan_finding MODIFY findingGuid VARCHAR(512);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_3', 'hp', 'dbF360_4.4.0.xml', NOW(), 355, '8:b26eacc5e1d8cb065bec727214a5e553', 'modifyDataType columnName=guid, tableName=finding; modifyDataType columnName=findingGuid, tableName=scan_finding', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_4::hp
--  Quartz upgrade from 2.1.x to 2.2.x
ALTER TABLE QRTZ_FIRED_TRIGGERS ADD SCHED_TIME BIGINT DEFAULT 0 NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_4', 'hp', 'dbF360_4.4.0.xml', NOW(), 357, '8:950d099ae491ab76dc1376e8053776cf', 'addColumn tableName=QRTZ_FIRED_TRIGGERS', 'Quartz upgrade from 2.1.x to 2.2.x', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_5::hp
--  Remove unused data tables
DROP TABLE systemsettingmultichoicevalue;

DROP TABLE systemsettingmultichoiceoption;

DROP TABLE systemsettingfilevalue;

DROP TABLE systemsettingbooleanvalue;

DROP TABLE systemsettinglongstringvalue;

DROP TABLE systemsettingshortstringvalue;

DROP TABLE systemsettingvalue;

DROP TABLE systemsetting;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_5', 'hp', 'dbF360_4.4.0.xml', NOW(), 359, '8:e02bcc043f6284e893c38f1ce637d213', 'dropTable tableName=systemsettingmultichoicevalue; dropTable tableName=systemsettingmultichoiceoption; dropTable tableName=systemsettingfilevalue; dropTable tableName=systemsettingbooleanvalue; dropTable tableName=systemsettinglongstringvalue; dro...', 'Remove unused data tables', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_6::hp
--  Increasing sie of the comment text column to let users post longer comments.
ALTER TABLE auditcomment MODIFY commentText VARCHAR(4000);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_6', 'hp', 'dbF360_4.4.0.xml', NOW(), 361, '8:01e7a259ac987093e558aef07164b73a', 'modifyDataType columnName=commentText, tableName=auditcomment', 'Increasing sie of the comment text column to let users post longer comments.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_7::hp
--  Add new column to save annotations counter of scan
ALTER TABLE scan ADD fortifyAnnotationsLoc INT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_7', 'hp', 'dbF360_4.4.0.xml', NOW(), 363, '8:e60ef64f650797fb5d60e19c6006cefe', 'addColumn tableName=scan', 'Add new column to save annotations counter of scan', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_8::hp
--  Add new table for bugtracker templates
CREATE TABLE bugtrackertemplate (bugtracker VARCHAR(127) NOT NULL, template_field_id VARCHAR(250) NOT NULL, template_value VARCHAR(4000) NULL);

ALTER TABLE bugtrackertemplate ADD PRIMARY KEY (bugtracker, template_field_id);

INSERT INTO bugtrackertemplate (bugtracker, template_field_id, template_value) VALUES ('default', 'summary', 'Fix $ATTRIBUTE_CATEGORY in $ATTRIBUTE_FILE');

INSERT INTO bugtrackertemplate (bugtracker, template_field_id, template_value) VALUES ('default', 'description', '#foreach( $is in $issues ) Issue Ids: $is.get("ATTRIBUTE_INSTANCE_ID") | $is.get("ISSUE_DEEPLINK") | $is.get("ATTRIBUTE_FILE")             #end');

INSERT INTO bugtrackertemplate (bugtracker, template_field_id, template_value) VALUES ('jira', 'summary', 'Fix $ATTRIBUTE_CATEGORY in $ATTRIBUTE_FILE');

INSERT INTO bugtrackertemplate (bugtracker, template_field_id, template_value) VALUES ('jira', 'description', 'Issue Ids: $ATTRIBUTE_INSTANCE_ID $ISSUE_DEEPLINK');

INSERT INTO bugtrackertemplate (bugtracker, template_field_id, template_value) VALUES ('hp alm', 'summary', 'Fix $ATTRIBUTE_CATEGORY in $ATTRIBUTE_FILE');

INSERT INTO bugtrackertemplate (bugtracker, template_field_id, template_value) VALUES ('hp alm', 'description', 'Issue Ids: $ATTRIBUTE_INSTANCE_ID $ISSUE_DEEPLINK');

INSERT INTO bugtrackertemplate (bugtracker, template_field_id, template_value) VALUES ('bugzilla', 'summary', 'Fix $ATTRIBUTE_CATEGORY in $ATTRIBUTE_FILE');

INSERT INTO bugtrackertemplate (bugtracker, template_field_id, template_value) VALUES ('bugzilla', 'description', 'Issue Ids: $ATTRIBUTE_INSTANCE_ID $ISSUE_DEEPLINK');

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_8', 'hp', 'dbF360_4.4.0.xml', NOW(), 365, '8:152abb0e5af819e0c0983127da53d0cf', 'createTable tableName=bugtrackertemplate; addPrimaryKey tableName=bugtrackertemplate; insert tableName=bugtrackertemplate; insert tableName=bugtrackertemplate; insert tableName=bugtrackertemplate; insert tableName=bugtrackertemplate; insert tableN...', 'Add new table for bugtracker templates', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_9::hp
--  Adds a new column with fulltext indexing status
ALTER TABLE artifact ADD indexed TINYINT(1) DEFAULT 0 NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_9', 'hp', 'dbF360_4.4.0.xml', NOW(), 367, '8:3e3d100824ea37172e0a5fdd1b7345d2', 'addColumn tableName=artifact', 'Adds a new column with fulltext indexing status', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_10::hp
--  New index to improve searching number of issues assigned to specific user(s) across all project versions.
CREATE INDEX USER_SUPPRESSED_SCANSTAT_IDX ON issue(userName, suppressed, scanStatus, projectVersion_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_10', 'hp', 'dbF360_4.4.0.xml', NOW(), 369, '8:579b0a306af3b5842861aeb9af38a92a', 'createIndex indexName=USER_SUPPRESSED_SCANSTAT_IDX, tableName=issue', 'New index to improve searching number of issues assigned to specific user(s) across all project versions.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_11::hp
--  Enlarge rulepack.locale column so it can hold xx_XX locale names.
ALTER TABLE rulepack MODIFY locale VARCHAR(5);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_11', 'hp', 'dbF360_4.4.0.xml', NOW(), 371, '8:335edc0d7fc26a8feb49368c44006405', 'modifyDataType columnName=locale, tableName=rulepack', 'Enlarge rulepack.locale column so it can hold xx_XX locale names.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_12::hp
--  Index maintenance job scheduler configuration
INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`) VALUES ('scheduler', 'index.maintenance.daysOfWeek', '*', 'A comma-separated list of the daysOfWeek for the index maintenance job to run. * means run every day. 1 means Sunday, 2 means Monday, etc.');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`) VALUES ('scheduler', 'index.maintenance.hours', '0', 'A comma-separated list of the hours of the day for the index maintenance job to run. * means run every hour.');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`) VALUES ('scheduler', 'index.maintenance.minutes', '0', 'A comma-separated list of the minutes of each hour for the index maintenance job to run. Do not run more than once every 5 minutes.');

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_12', 'hp', 'dbF360_4.4.0.xml', NOW(), 373, '8:9de3e3cab17edc28787ab0c0e8d5b51f', 'insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty', 'Index maintenance job scheduler configuration', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_13::hp
--  SSL/TLS email configuration properties
INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('email', 'email.server.ssl.enabled', 'false', 'Enable SSL/TLS Encryption', 'BOOLEAN');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType) VALUES ('email', 'email.server.ssl.trustHostCertificate', 'false', 'Trust the certificate provided by the SMTP server', 'BOOLEAN');

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_13', 'hp', 'dbF360_4.4.0.xml', NOW(), 375, '8:5a1362072076eb3ebe5af91d0f013aa6', 'insert tableName=configproperty; insert tableName=configproperty', 'SSL/TLS email configuration properties', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_14::hp
--  SAML 2.0 integration properties
INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, groupSwitch) VALUES ('saml', 'saml.enabled', 'false', 'SAML 2.0 Integration', 'BOOLEAN', 'Y');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, propertyOrder) VALUES ('saml', 'saml.idp.metadata', 'http://', 'Identity provider metadata location', 'STRING', 10);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, propertyOrder) VALUES ('saml', 'saml.idp.default', 'http://', 'Default identity provider', 'STRING', 20);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, propertyOrder) VALUES ('saml', 'saml.sp.entityId', 'urn:ssc:saml', 'Service provider entity ID, must be globally unique across federations', 'STRING', 30);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, propertyOrder) VALUES ('saml', 'saml.sp.alias', 'urn:ssc:saml', 'Service provider alias', 'STRING', 40);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, propertyOrder) VALUES ('saml', 'saml.keystore.location', 'file:///', 'Keystore location', 'STRING', 50);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, propertyOrder) VALUES ('saml', 'saml.keystore.password', '', 'Keystore password', 'ENCODEDHIDDEN', 60);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, propertyOrder) VALUES ('saml', 'saml.key.alias', '', 'Key for signing and encryption of SAML messages', 'STRING', 70);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, propertyOrder) VALUES ('saml', 'saml.key.password', '', 'Key password', 'ENCODEDHIDDEN', 80);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, propertyOrder) VALUES ('saml', 'saml.assertion.username', 'NameID', 'Assertion attribute which holds username, NameID by default', 'STRING', 90);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_14', 'hp', 'dbF360_4.4.0.xml', NOW(), 377, '8:3c819473098e041a0d112381ed839ac9', 'insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName...', 'SAML 2.0 integration properties', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_15::hp
--  Adding support for configuration sub groups
ALTER TABLE configproperty ADD subGroupName VARCHAR(100) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_15', 'hp', 'dbF360_4.4.0.xml', NOW(), 379, '8:c8acc58d0ee7ccdd504efb165037b29f', 'addColumn tableName=configproperty', 'Adding support for configuration sub groups', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.0.xml::f360_4.4.0_16::hp
UPDATE configproperty SET propertyType = 'ENCODEDHIDDEN' WHERE propertyName = 'birt.report.username';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.0_16', 'hp', 'dbF360_4.4.0.xml', NOW(), 381, '8:d9545f03c049c27dabf40ff53470593e', 'update tableName=configproperty', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_4.4.0.xml::f360Mysql_4.4.0_1::hp
ALTER TABLE `QRTZ_JOB_DETAILS` MODIFY COLUMN `JOB_DATA` MEDIUMBLOB;

ALTER TABLE `QRTZ_TRIGGERS` MODIFY COLUMN `JOB_DATA` MEDIUMBLOB;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_4.4.0_1', 'hp', 'dbF360Mysql_4.4.0.xml', NOW(), 383, '8:e4194c3c0535ae6abf91cd12a16c339f', 'sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.1.xml::f360_4.4.1_0::hp
DELETE FROM QRTZ_CRON_TRIGGERS;

DELETE FROM QRTZ_FIRED_TRIGGERS;

DELETE FROM QRTZ_SIMPLE_TRIGGERS;

DELETE FROM QRTZ_TRIGGERS;

DELETE FROM QRTZ_JOB_DETAILS;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.1_0', 'hp', 'dbF360_4.4.1.xml', NOW(), 385, '8:c95ffcd6afe3099610ff281793eb8c01', 'delete tableName=QRTZ_CRON_TRIGGERS; delete tableName=QRTZ_FIRED_TRIGGERS; delete tableName=QRTZ_SIMPLE_TRIGGERS; delete tableName=QRTZ_TRIGGERS; delete tableName=QRTZ_JOB_DETAILS', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.4.1.xml::f360_4.4.1_1::hp
--  Add index on sourcefilemap.checksum
CREATE INDEX SOURCEFILEMAP_CHECKSUM_IDX ON sourcefilemap(checksum);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.4.1_1', 'hp', 'dbF360_4.4.1.xml', NOW(), 387, '8:8c53500856ffd51f940eed772d677a3a', 'createIndex indexName=SOURCEFILEMAP_CHECKSUM_IDX, tableName=sourcefilemap', 'Add index on sourcefilemap.checksum', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_0::hp
--  Solve slow SQL for issue search
DROP INDEX idx_id_table_session_date_id ON id_table;

DROP TABLE id_table;

CREATE TABLE id_table (id_num INT NOT NULL, session_date BIGINT NOT NULL, session_id INT NOT NULL, id INT NOT NULL);

CREATE INDEX pk_id_table ON id_table(session_date, session_id, id_num, id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_0', 'hp', 'dbF360_4.5.0.xml', NOW(), 389, '8:9e179d243c0b258e375975b6f1d2f409', 'dropIndex indexName=idx_id_table_session_date_id, tableName=id_table; dropTable tableName=id_table; createTable tableName=id_table; createIndex indexName=pk_id_table, tableName=id_table', 'Solve slow SQL for issue search', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_1::hp
--  Adding support of required flag for properties
ALTER TABLE configproperty ADD required VARCHAR(1) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_1', 'hp', 'dbF360_4.5.0.xml', NOW(), 391, '8:1ef1df727faf318453f0905946dcfdac', 'addColumn tableName=configproperty', 'Adding support of required flag for properties', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_2::hp
--  Adding support of protected option flag for properties
ALTER TABLE configproperty ADD protectedOption VARCHAR(1) DEFAULT 'Y' NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_2', 'hp', 'dbF360_4.5.0.xml', NOW(), 393, '8:aa1bfdaee1f4230ed2e99f0e1d995343', 'addColumn tableName=configproperty', 'Adding support of protected option flag for properties', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_3::hp
--  LDAP configuration in DB.
CREATE TABLE ldapserver (id INT AUTO_INCREMENT NOT NULL, objectVersion INT DEFAULT 1 NOT NULL, updateTime datetime NOT NULL, serverName VARCHAR(200) NOT NULL, defaultServer VARCHAR(1) NOT NULL, enabled VARCHAR(1) NOT NULL, baseDn VARCHAR(255) NOT NULL, searchDns VARCHAR(1000) NULL, url VARCHAR(250) NOT NULL, userDn VARCHAR(600) NOT NULL, userPassword VARCHAR(600) NOT NULL, cacheEnabled VARCHAR(1) NOT NULL, cacheExecutorPoolSize INT NOT NULL, cacheMaxThreadsPerCache INT NOT NULL, cacheExecutorPoolSizeMax INT NOT NULL, cacheEvictionTime INT NOT NULL, pagingEnabled VARCHAR(1) NOT NULL, pageSize INT NOT NULL, userPhotoEnabled VARCHAR(1) NOT NULL, nestedGroupsEnabled VARCHAR(1) NOT NULL, ignorePartialResultException VARCHAR(1) NOT NULL, validationIdleTime INT NOT NULL, validationTimeLimit INT NOT NULL, attributeGroupname VARCHAR(150) NOT NULL, attributeFirstName VARCHAR(150) NOT NULL, attributeLastName VARCHAR(150) NOT NULL, attributeOrgunitName VARCHAR(150) NOT NULL, attributeMember VARCHAR(150) NOT NULL, attributeMemberOf VARCHAR(150) NOT NULL, attributeObjectSid VARCHAR(150) NULL, attributeEmail VARCHAR(150) NOT NULL, attributeDistinguishedName VARCHAR(150) NOT NULL, attributeObjectClass VARCHAR(150) NOT NULL, attributeUserName VARCHAR(150) NOT NULL, attributePassword VARCHAR(150) NULL, attributeThumbnailPhoto VARCHAR(150) NULL, attributeThumbnailMimeDefault VARCHAR(50) NULL, authenticatorType VARCHAR(50) NOT NULL, passwordEncoderType VARCHAR(50) NOT NULL, baseObjectSid VARCHAR(150) NULL, classUser VARCHAR(150) NOT NULL, classGroup VARCHAR(150) NOT NULL, classOrgunit VARCHAR(150) NOT NULL, referralsProcessingStrategy VARCHAR(50) NOT NULL, CONSTRAINT ldapServerPk PRIMARY KEY (id));

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_3', 'hp', 'dbF360_4.5.0.xml', NOW(), 395, '8:9b76da900d3364ac4d7bfcff0e71bc5f', 'createTable tableName=ldapserver', 'LDAP configuration in DB.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_3.1::hp
--  Solves index creation issues for MySQL utf8_bin collation. MUST RUN BEFORE creating indexes for ldapserver table.
ALTER TABLE `ldapserver` ROW_FORMAT=DYNAMIC;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_3.1', 'hp', 'dbF360_4.5.0.xml', NOW(), 397, '8:f27598afb04a29c360c5d04edc444680', 'sql', 'Solves index creation issues for MySQL utf8_bin collation. MUST RUN BEFORE creating indexes for ldapserver table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_3.2::hp
CREATE UNIQUE INDEX LDAP_SERVER_BASE_DN_IDX ON ldapserver(baseDn);

CREATE UNIQUE INDEX LDAP_SERVER_NAME_IDX ON ldapserver(serverName);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_3.2', 'hp', 'dbF360_4.5.0.xml', NOW(), 399, '8:d7f997e5bdd59f1ba7f89a6924646cef', 'createIndex indexName=LDAP_SERVER_BASE_DN_IDX, tableName=ldapserver; createIndex indexName=LDAP_SERVER_NAME_IDX, tableName=ldapserver', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_4::hp
--  Adding table for user UI preferences
CREATE TABLE usersessionstate (id INT AUTO_INCREMENT NOT NULL, userName VARCHAR(255) NOT NULL, name VARCHAR(255) NULL, value VARCHAR(1024) NULL, category VARCHAR(100) NULL, projectVersionId INT NULL, CONSTRAINT userSessionStatePK PRIMARY KEY (id));

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_4', 'hp', 'dbF360_4.5.0.xml', NOW(), 401, '8:75e264af5f1499a0f04f3ce72c048f3a', 'createTable tableName=usersessionstate', 'Adding table for user UI preferences', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_5::hp
--  scan_issue link is no longer used. scanissueview redefined to remove dependency
DROP VIEW scanissueview;

CREATE VIEW scanissueview AS SELECT si.scan_id, si.id, si.issue_id, si.issueInstanceId, s.startDate, s.engineType, s.projectVersion_id
            FROM scan s INNER JOIN scan_issue si ON si.scan_id = s.id;

DROP TABLE scan_issue_link;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_5', 'hp', 'dbF360_4.5.0.xml', NOW(), 403, '8:bbfad5d91cbee2b643eefc26bc4a17ce', 'dropView viewName=scanissueview; createView viewName=scanissueview; dropTable tableName=scan_issue_link', 'scan_issue link is no longer used. scanissueview redefined to remove dependency', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_6::hp
CREATE TABLE cloudworker (id BIGINT AUTO_INCREMENT NOT NULL, uuid VARCHAR(36) NOT NULL, processUuid VARCHAR(36) NOT NULL, state VARCHAR(25) NOT NULL, lastChangedOn BIGINT NOT NULL, workerStartTime datetime NULL, workerExpiryTime datetime NULL, lastSeen datetime NULL, lastActivity VARCHAR(100) NULL, ipAddress VARCHAR(45) NULL, scaVersion VARCHAR(128) NULL, vmName VARCHAR(255) NULL, availableProcessors INT NULL, totalPhysicalMemory BIGINT NULL, osName VARCHAR(255) NULL, osVersion VARCHAR(255) NULL, osArchitecture VARCHAR(255) NULL, CONSTRAINT PK_CLOUDWORKER PRIMARY KEY (id));

CREATE INDEX WORKER_LASTCHANGEDON_IDX ON cloudworker(lastChangedOn);

CREATE UNIQUE INDEX UQ_WORKER_UUID_IDX ON cloudworker(uuid);

CREATE UNIQUE INDEX UQ_WORKER_PROC_UUID_IDX ON cloudworker(processUuid);

CREATE INDEX WORKER_EXPIRYTIME_IDX ON cloudworker(workerExpiryTime);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_6', 'hp', 'dbF360_4.5.0.xml', NOW(), 405, '8:4a183a949a15a88686a36e9261b37237', 'createTable tableName=cloudworker; createIndex indexName=WORKER_LASTCHANGEDON_IDX, tableName=cloudworker; createIndex indexName=UQ_WORKER_UUID_IDX, tableName=cloudworker; createIndex indexName=UQ_WORKER_PROC_UUID_IDX, tableName=cloudworker; create...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_7::hp
CREATE TABLE cloudjob (id BIGINT AUTO_INCREMENT NOT NULL, jobToken VARCHAR(36) NOT NULL, lastChangedOn BIGINT NOT NULL, scaBuildId VARCHAR(100) NULL, scaVersion VARCHAR(128) NULL, scaArgs VARCHAR(4000) NULL, workerUuid VARCHAR(36) NULL, workerProcessUuid VARCHAR(36) NULL, submitterUserName VARCHAR(255) NULL, submitterIpAddress VARCHAR(45) NULL, submitterEmail VARCHAR(255) NULL, jobState VARCHAR(25) NOT NULL, jobQueuedTime datetime NULL, jobStartedTime datetime NULL, jobFinishedTime datetime NULL, jobExpiryTime datetime NULL, jobHasLog CHAR(1) NULL, jobHasFpr CHAR(1) NULL, cloudWorker_id BIGINT NULL, projectVersion_id BIGINT NULL, CONSTRAINT PK_CLOUDJOB PRIMARY KEY (id));

CREATE UNIQUE INDEX UQ_CLOUDJOB_JOBTOKEN_IDX ON cloudjob(jobToken);

CREATE INDEX CLOUDJOB_JOBSTATE_IDX ON cloudjob(jobState);

CREATE UNIQUE INDEX UQ_CLOUDJOB_LASTCHANGEDON_IDX ON cloudjob(lastChangedOn);

CREATE INDEX CLOUDJOB_EXPIRYTIME_IDX ON cloudjob(jobExpiryTime);

CREATE INDEX FK_CLOUDJOB_WORKER_IDX ON cloudjob(cloudWorker_id);

ALTER TABLE cloudjob ADD CONSTRAINT RefCloudWorker FOREIGN KEY (cloudWorker_id) REFERENCES cloudworker (id) ON DELETE SET NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_7', 'hp', 'dbF360_4.5.0.xml', NOW(), 407, '8:8216b901a82355730a4a578c150d358a', 'createTable tableName=cloudjob; createIndex indexName=UQ_CLOUDJOB_JOBTOKEN_IDX, tableName=cloudjob; createIndex indexName=CLOUDJOB_JOBSTATE_IDX, tableName=cloudjob; createIndex indexName=UQ_CLOUDJOB_LASTCHANGEDON_IDX, tableName=cloudjob; createInd...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_8::hp
--  Removal of BugStateManagement jobs from the job queue
DELETE FROM jobqueue WHERE jobClassName = 'com.fortify.manager.BLL.jobs.BugStateManagementJob';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_8', 'hp', 'dbF360_4.5.0.xml', NOW(), 409, '8:d386d092d96885682921033659e1c896', 'delete tableName=jobqueue', 'Removal of BugStateManagement jobs from the job queue', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_9::hp
ALTER TABLE jobqueue ADD priority INT DEFAULT 0 NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_9', 'hp', 'dbF360_4.5.0.xml', NOW(), 411, '8:2ccb91eb1d8e3c6075d84e318b5caa74', 'addColumn tableName=jobqueue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_11::hp
--  Kerberos integration properties
INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, groupSwitch, required) VALUES ('kerberos', 'kerberos.enabled', 'false', 'SPNEGO/Kerberos Integration', 'BOOLEAN', 'Y', 'N');

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, required, propertyOrder) VALUES ('kerberos', 'kerberos.service.principal', '', 'Service principal name (SPN)', 'STRING', 'Y', 10);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, required, propertyOrder) VALUES ('kerberos', 'kerberos.keytab.location', 'file:///', 'Keytab location with service principal keys.', 'STRING', 'Y', 20);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, required, propertyOrder) VALUES ('kerberos', 'kerberos.krb5conf.location', '', 'Optional krb5.conf file location. Sets the ''java.security.krb5.conf'' property.', 'STRING', 'N', 30);

INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, required, propertyOrder) VALUES ('kerberos', 'kerberos.debug', 'false', 'Enable debug mode of Kerberos integration', 'BOOLEAN', 'N', 40);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_11', 'hp', 'dbF360_4.5.0.xml', NOW(), 413, '8:d8242456bc41b1393038f9e3a9a62808', 'insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty; insert tableName=configproperty', 'Kerberos integration properties', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_12::hp
--  X509 integration properties
INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, groupSwitch, required, propertyOrder) VALUES ('x509', 'x509.username.pattern', 'CN=(.*?)(?:,|$)', 'X.509 certificate username pattern', 'STRING', 'N', 'Y', 10);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_12', 'hp', 'dbF360_4.5.0.xml', NOW(), 415, '8:143a26158b1858b2589b3ac5a4fa6861', 'insert tableName=configproperty', 'X509 integration properties', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_13::hp
--  Added hashValue column to store hash of ldap.properties to determine if file has been modified
ALTER TABLE ldapserver ADD hashValue INT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_13', 'hp', 'dbF360_4.5.0.xml', NOW(), 417, '8:97ae197f366e0feffecd6284af4d4e1e', 'addColumn tableName=ldapserver', 'Added hashValue column to store hash of ldap.properties to determine if file has been modified', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_14::hp
--  Change index jobqueue(executionOrder) from unique to non-unique
ALTER TABLE jobqueue DROP KEY UQ_EXECUTIONORDER;

CREATE INDEX EXECUTIONORDER_IDX ON jobqueue(executionOrder);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_14', 'hp', 'dbF360_4.5.0.xml', NOW(), 419, '8:1166abb08d7d7d5c0210710d1f7bc912', 'dropUniqueConstraint constraintName=UQ_EXECUTIONORDER, tableName=jobqueue; createIndex indexName=EXECUTIONORDER_IDX, tableName=jobqueue', 'Change index jobqueue(executionOrder) from unique to non-unique', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_15::hp
--  Add index jobqueue(state ASC, priority DESC, executionOrder DESC)
CREATE INDEX STATE_PRIO_EXECORDER_IDX ON jobqueue(state ASC, priority DESC, executionOrder ASC);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_15', 'hp', 'dbF360_4.5.0.xml', NOW(), 421, '8:92df809907efd196dbd7638490f1b9a0', 'createIndex indexName=STATE_PRIO_EXECORDER_IDX, tableName=jobqueue', 'Add index jobqueue(state ASC, priority DESC, executionOrder DESC)', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_16::hp_main
INSERT INTO configproperty (groupName, propertyName, propertyValue, valuesList, propertyType, `description`, required, propertyOrder) VALUES ('core', 'user.lookup.strategy', '3', 'Local users first, fallback to LDAP users (compatibility)|||||1-----LDAP users first, fallback to local users|||||2-----LDAP users exclusive, fallback to local administrator|||||3', 'OPTIONLIST', 'User lookup strategy when LDAP is enabled', 'Y', 45);

UPDATE configproperty SET propertyValue='1'
			WHERE groupName='core' AND propertyName='user.lookup.strategy'
			AND 0 < (
				SELECT count(userName) FROM fortifyuser fu
				INNER JOIN user_pt ON (fu.id=user_pt.user_id)
				INNER JOIN permissiontemplate pt ON (pt.id=user_pt.pt_id and pt.guid<>'admin')
			)
			AND 0 = (SELECT A.cnt FROM (
				SELECT count(cp.propertyValue) cnt FROM configproperty cp
				WHERE cp.propertyName IN ('saml.enabled', 'sso.enabled', 'kerberos.enabled', 'cas.enabled')
				AND cp.propertyValue='true'
			) A);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_16', 'hp_main', 'dbF360_4.5.0.xml', NOW(), 423, '8:6d57d0d6f96ae19ea5c264a6fcc5062b', 'insert tableName=configproperty; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_17::hp_main
--  Set WAITING_FOR_WORKER jobs as PREPARED
UPDATE jobqueue SET state = 0 WHERE state = 3;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_17', 'hp_main', 'dbF360_4.5.0.xml', NOW(), 425, '8:75b9631ece16792dea63fa7bfc38ba45', 'update tableName=jobqueue', 'Set WAITING_FOR_WORKER jobs as PREPARED', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_18::hp
--  Truncate QRTZ tables
DELETE FROM QRTZ_CRON_TRIGGERS;

DELETE FROM QRTZ_FIRED_TRIGGERS;

DELETE FROM QRTZ_SIMPLE_TRIGGERS;

DELETE FROM QRTZ_TRIGGERS;

DELETE FROM QRTZ_JOB_DETAILS;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_18', 'hp', 'dbF360_4.5.0.xml', NOW(), 427, '8:c95ffcd6afe3099610ff281793eb8c01', 'delete tableName=QRTZ_CRON_TRIGGERS; delete tableName=QRTZ_FIRED_TRIGGERS; delete tableName=QRTZ_SIMPLE_TRIGGERS; delete tableName=QRTZ_TRIGGERS; delete tableName=QRTZ_JOB_DETAILS', 'Truncate QRTZ tables', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_19::hp
--  Remove FK constraint RefIssueAuditAttach from auditattachment table
ALTER TABLE auditattachment DROP FOREIGN KEY RefIssueAuditAttach;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_19', 'hp', 'dbF360_4.5.0.xml', NOW(), 429, '8:176a0eee459a95322670e9b2ac6c0979', 'dropForeignKeyConstraint baseTableName=auditattachment, constraintName=RefIssueAuditAttach', 'Remove FK constraint RefIssueAuditAttach from auditattachment table', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_20::hp
UPDATE configproperty SET `description` = 'HPE Security Fortify Software security Center Location' WHERE groupName='cas' AND propertyName='cas.f360.server.location';

UPDATE configproperty SET `description` = 'Enable SSO Integration. WARNING: Single-Sign-On should only be enabled for a locked-down HPE Security Fortify Software Security Center instance, with Apache Agent capable of SSO authentication in front. The SSO-enabled Apache Agent should pass trusted HTTP headers to SSC. For more information, please refer to HPE Security Fortify Software Security Center Deployment Guide' WHERE groupName='sso' AND propertyName='sso.enabled';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_20', 'hp', 'dbF360_4.5.0.xml', NOW(), 431, '8:86b3fd026d3941c6659c600acc375a18', 'update tableName=configproperty; update tableName=configproperty', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_21::hp
ALTER TABLE alerthistory ADD triggeredValue VARCHAR(255) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_21', 'hp', 'dbF360_4.5.0.xml', NOW(), 433, '8:8c096303a800aa6137f0aa587a5029b2', 'addColumn tableName=alerthistory', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_4.5.0.xml::f360_4.5.0_22::hp
--  Add FK constraint RefRTProjTempl on projectTemplate_id
ALTER TABLE requirementtemplate ADD CONSTRAINT RefRTProjTempl FOREIGN KEY (projectTemplate_id) REFERENCES projecttemplate (id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_4.5.0_22', 'hp', 'dbF360_4.5.0.xml', NOW(), 435, '8:0a69225940ac2b057c473565a5d644d0', 'addForeignKeyConstraint baseTableName=requirementtemplate, constraintName=RefRTProjTempl, referencedTableName=projecttemplate', 'Add FK constraint RefRTProjTempl on projectTemplate_id', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20_audithistory.xml::f360_16.20_audithistory_1::hp
--  Audit history values conversion
DROP VIEW audithistoryview;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_audithistory_1', 'hp', 'dbF360_16.20_audithistory.xml', NOW(), 437, '8:fdc6213eda106bc194934860bed39053', 'dropView viewName=audithistoryview', 'Audit history values conversion', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20_audithistory.xml::f360_16.20_audithistory_2::hp
ALTER TABLE audithistory RENAME audithistory_old;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_audithistory_2', 'hp', 'dbF360_16.20_audithistory.xml', NOW(), 439, '8:9fe73fe8dba34ccfd45eec4a6c735805', 'renameTable newTableName=audithistory_old, oldTableName=audithistory', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20_audithistory.xml::f360_16.20_audithistory_4::hp
CREATE TABLE audithistory (issue_id BIGINT NOT NULL, attrGuid VARCHAR(255) NULL, seqNumber BIGINT NOT NULL, projectVersion_id BIGINT NULL, auditTime BIGINT NULL, oldValue VARCHAR(500) NULL, newValue VARCHAR(500) NULL, userName VARCHAR(255) NULL, conflict CHAR(1) NULL, CONSTRAINT PK_AUDITHISTORY PRIMARY KEY (issue_id, seqNumber));

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_audithistory_4', 'hp', 'dbF360_16.20_audithistory.xml', NOW(), 441, '8:c4e4af677e0b9e94c89b67e4f76a4f30', 'createTable tableName=audithistory', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_16.20_audithistory.xml::f360Mysql_16.20_0::hp
--  Audit history value migration
INSERT INTO
    audithistory (`issue_id`, `seqNumber`, `attrGuid`, `auditTime`, `oldValue`, `newValue`, `userName`, `conflict`, `projectVersion_id`)
    SELECT
        aho.`issue_id`, aho.`seqNumber`, aho.`attrGuid`, aho.`auditTime`,
        (CASE WHEN aho.oldValue IS NULL THEN NULL
            WHEN alOld.lookupValue IS NULL THEN CAST(aho.oldValue as char(500))
            ELSE alOld.lookupValue END),
        (CASE WHEN aho.newValue IS NULL THEN NULL
            WHEN alNew.lookupValue IS NULL THEN CAST(aho.newValue as char(500))
            ELSE alNew.lookupValue END),
        aho.`userName`, aho.`conflict`, aho.`projectVersion_id`
    FROM audithistory_old aho
        INNER JOIN attr a ON aho.attrGuid = a.guid
        LEFT JOIN attrlookup alNew ON alNew.attrGuid = aho.attrGuid AND aho.newValue = alNew.lookupIndex
        LEFT JOIN attrlookup alOld ON alOld.attrGuid = aho.attrGuid AND aho.oldValue = alOld.lookupIndex
    WHERE a.attrType = 'CUSTOM'
UNION ALL
    SELECT
        aho.`issue_id`, aho.`seqNumber`, aho.`attrGuid`, aho.`auditTime`,
        (CASE WHEN aho.oldValue = 0 THEN 'false'
            WHEN aho.oldValue = 1 THEN 'true'
            ELSE NULL END),
        (CASE WHEN aho.newValue = 0 THEN 'false'
            WHEN aho.newValue = 1 THEN 'true'
            ELSE NULL END),
        aho.`userName`, aho.`conflict`, aho.`projectVersion_id`
    FROM audithistory_old aho
    WHERE aho.attrGuid = '22222222-2222-2222-2222-222222222222'
UNION ALL
    SELECT
        aho.`issue_id`, aho.`seqNumber`, aho.`attrGuid`, aho.`auditTime`,
        (CASE WHEN aho.oldValue IS NULL THEN NULL
            WHEN upOld.userName IS NULL THEN CAST(aho.oldValue as char(500))
            ELSE upOld.userName END),
        (CASE WHEN aho.newValue IS NULL THEN NULL
            WHEN upNew.userName IS NULL THEN CAST(aho.newValue as char(500))
            ELSE upNew.userName END),
        aho.`userName`, aho.`conflict`, aho.`projectVersion_id`
    FROM audithistory_old aho
        LEFT JOIN userpreference upOld ON aho.oldValue = upOld.id
        LEFT JOIN userpreference upNew ON aho.newValue = upNew.id
    WHERE aho.attrGuid = 'User';

INSERT INTO
    audithistory (`issue_id`, `seqNumber`, `attrGuid`, `auditTime`, `oldValue`, `newValue`, `userName`, `conflict`, `projectVersion_id`)
SELECT
    aho.`issue_id`, aho.`seqNumber`, aho.`attrGuid`, aho.`auditTime`,
    (CASE WHEN aho.oldValue IS NULL THEN NULL ELSE CAST(aho.oldValue AS char(500)) END),
    (CASE WHEN aho.newValue IS NULL THEN NULL ELSE CAST(aho.newValue AS char(500)) END),
    aho.`userName`, aho.`conflict`, aho.`projectVersion_id` 
FROM audithistory_old aho 
WHERE NOT EXISTS (SELECT 1 
                    FROM audithistory ah 
                    WHERE aho.issue_id = ah.issue_id AND aho.seqNumber = ah.seqNumber);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_16.20_0', 'hp', 'dbF360Mysql_16.20_audithistory.xml', NOW(), 443, '8:8fab0947eb9ba10f5f26a8349c3fb892', 'sql', 'Audit history value migration', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_0::hp
DROP TABLE QRTZ_SIMPLE_TRIGGERS;

DROP TABLE QRTZ_CRON_TRIGGERS;

DROP TABLE QRTZ_SIMPROP_TRIGGERS;

DROP TABLE QRTZ_FIRED_TRIGGERS;

DROP TABLE QRTZ_PAUSED_TRIGGER_GRPS;

DROP TABLE QRTZ_LOCKS;

DROP TABLE QRTZ_CALENDARS;

DROP TABLE QRTZ_SCHEDULER_STATE;

DROP TABLE QRTZ_BLOB_TRIGGERS;

DROP TABLE QRTZ_TRIGGERS;

DROP TABLE QRTZ_JOB_DETAILS;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_0', 'hp', 'dbF360_16.20.xml', NOW(), 445, '8:4b844389d682eb4df2f187f8b2bafd27', 'dropTable tableName=QRTZ_SIMPLE_TRIGGERS; dropTable tableName=QRTZ_CRON_TRIGGERS; dropTable tableName=QRTZ_SIMPROP_TRIGGERS; dropTable tableName=QRTZ_FIRED_TRIGGERS; dropTable tableName=QRTZ_PAUSED_TRIGGER_GRPS; dropTable tableName=QRTZ_LOCKS; dro...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_1::hp
--  Create cloudpool table
CREATE TABLE cloudpool (id BIGINT AUTO_INCREMENT NOT NULL, uuid VARCHAR(36) NOT NULL, `path` VARCHAR(255) NULL, name VARCHAR(255) NULL, `description` VARCHAR(1999) NULL, lastChangedOn BIGINT NOT NULL, CONSTRAINT PK_CLOUDPOOL PRIMARY KEY (id));

CREATE INDEX CLOUDPOOL_LASTCHANGEDON_IDX ON cloudpool(lastChangedOn);

CREATE UNIQUE INDEX UQ_CLOUDPOOL_UUID_IDX ON cloudpool(uuid);

CREATE INDEX CLOUDPOOL_PATH_IDX ON cloudpool(`path`);

CREATE INDEX CLOUDPOOL_NAME_IDX ON cloudpool(name);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_1', 'hp', 'dbF360_16.20.xml', NOW(), 447, '8:fe06e84f30e11f63ce011b2094c9d70d', 'createTable tableName=cloudpool; createIndex indexName=CLOUDPOOL_LASTCHANGEDON_IDX, tableName=cloudpool; createIndex indexName=UQ_CLOUDPOOL_UUID_IDX, tableName=cloudpool; createIndex indexName=CLOUDPOOL_PATH_IDX, tableName=cloudpool; createIndex i...', 'Create cloudpool table', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_2::hp
--  Add hostName and cloudPool_id columns to cloudworker table
ALTER TABLE cloudworker ADD hostName VARCHAR(255) NULL, ADD cloudPool_id BIGINT NULL;

ALTER TABLE cloudworker ADD CONSTRAINT RefWorkerCloudPool FOREIGN KEY (cloudPool_id) REFERENCES cloudpool (id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_2', 'hp', 'dbF360_16.20.xml', NOW(), 449, '8:fe6455a104051656853a0388aa7b8a9b', 'addColumn tableName=cloudworker; addForeignKeyConstraint baseTableName=cloudworker, constraintName=RefWorkerCloudPool, referencedTableName=cloudpool', 'Add hostName and cloudPool_id columns to cloudworker table', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_3::hp
--  Add cloudPool_id column to cloudjob table, change index on lastChangedOn, migrate removed state
ALTER TABLE cloudjob ADD cloudPool_id BIGINT NULL;

ALTER TABLE cloudjob ADD CONSTRAINT RefJobCloudPool FOREIGN KEY (cloudPool_id) REFERENCES cloudpool (id);

DROP INDEX UQ_CLOUDJOB_LASTCHANGEDON_IDX ON cloudjob;

CREATE INDEX CLOUDJOB_LASTCHANGEDON_IDX ON cloudjob(lastChangedOn);

UPDATE cloudjob SET jobState = 'SCAN_RUNNING' WHERE jobState = 'SCAN_QUEUED';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_3', 'hp', 'dbF360_16.20.xml', NOW(), 451, '8:32582858b681810b5a94c0015cf27b91', 'addColumn tableName=cloudjob; addForeignKeyConstraint baseTableName=cloudjob, constraintName=RefJobCloudPool, referencedTableName=cloudpool; dropIndex indexName=UQ_CLOUDJOB_LASTCHANGEDON_IDX, tableName=cloudjob; createIndex indexName=CLOUDJOB_LAST...', 'Add cloudPool_id column to cloudjob table, change index on lastChangedOn, migrate removed state', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_4::hp
--  Create cloudpool_projectversion table
CREATE TABLE projectversion_cloudpool (projectVersion_id BIGINT NOT NULL, cloudPool_id BIGINT NOT NULL, CONSTRAINT PK_PROJECTVERSION_CLOUDPOOL PRIMARY KEY (projectVersion_id));

CREATE INDEX PVCP_CLOUDPOOL_ID_IDX ON projectversion_cloudpool(cloudPool_id);

ALTER TABLE projectversion_cloudpool ADD CONSTRAINT RefPVCPCloudPool FOREIGN KEY (cloudPool_id) REFERENCES cloudpool (id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_4', 'hp', 'dbF360_16.20.xml', NOW(), 453, '8:a8c2df279f8497343e9d76eaa838084f', 'createTable tableName=projectversion_cloudpool; createIndex indexName=PVCP_CLOUDPOOL_ID_IDX, tableName=projectversion_cloudpool; addForeignKeyConstraint baseTableName=projectversion_cloudpool, constraintName=RefPVCPCloudPool, referencedTableName=c...', 'Create cloudpool_projectversion table', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_5::hp
--  Add value typing to tag definitions
ALTER TABLE attr ADD valueType VARCHAR(20) NULL;

UPDATE attr SET valueType = 'LIST' WHERE attrType = 'CUSTOM';

CREATE INDEX ATTR_VALUETYPE_IDX ON attr(valueType);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_5', 'hp', 'dbF360_16.20.xml', NOW(), 455, '8:cdfdd83101a00cee56569605a076a9b9', 'addColumn tableName=attr; update tableName=attr; createIndex indexName=ATTR_VALUETYPE_IDX, tableName=attr', 'Add value typing to tag definitions', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_6::hp
--  Add support to multiple audit value types
ALTER TABLE auditvalue ADD decimalValue DECIMAL(18, 9) NULL, ADD dateValue date NULL, ADD textValue VARCHAR(500) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_6', 'hp', 'dbF360_16.20.xml', NOW(), 457, '8:2bad2198b36a278032a5b99938c82562', 'addColumn tableName=auditvalue', 'Add support to multiple audit value types', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_7::hp
--  Velocity templates for Bug filing
CREATE TABLE bugfieldtemplategroup (id BIGINT AUTO_INCREMENT NOT NULL, objectVersion INT DEFAULT 1 NOT NULL, name VARCHAR(255) NOT NULL, `description` VARCHAR(500) NULL, bugTrackerPluginId VARCHAR(255) NOT NULL, CONSTRAINT PK_BUGFIELDTEMPLATEGROUP PRIMARY KEY (id), CONSTRAINT UK_BugfieldTemplateGroupName UNIQUE (name));

CREATE TABLE bugfieldtemplate (id BIGINT AUTO_INCREMENT NOT NULL, bugfieldTemplateGroup_id BIGINT NOT NULL, fieldName VARCHAR(255) NOT NULL, fieldValue MEDIUMTEXT NULL, CONSTRAINT PK_BUGFIELDTEMPLATE PRIMARY KEY (id));

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_7', 'hp', 'dbF360_16.20.xml', NOW(), 459, '8:9f78f9a72eded89df0b3bbe20a802ca8', 'createTable tableName=bugfieldtemplategroup; createTable tableName=bugfieldtemplate', 'Velocity templates for Bug filing', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_9::hp
ALTER TABLE bugfieldtemplate ADD CONSTRAINT FK_BugfieldTemplateGroupId FOREIGN KEY (bugfieldTemplateGroup_id) REFERENCES bugfieldtemplategroup (id) ON DELETE CASCADE;

CREATE INDEX BT_BTG_IDX ON bugfieldtemplate(bugfieldTemplateGroup_id);

ALTER TABLE bugfieldtemplate ADD CONSTRAINT UQ_BugfieldName UNIQUE (bugfieldTemplateGroup_id, fieldName);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_9', 'hp', 'dbF360_16.20.xml', NOW(), 461, '8:c66b4c35505f3501d1f67a21928fc0d7', 'addForeignKeyConstraint baseTableName=bugfieldtemplate, constraintName=FK_BugfieldTemplateGroupId, referencedTableName=bugfieldtemplategroup; createIndex indexName=BT_BTG_IDX, tableName=bugfieldtemplate; addUniqueConstraint constraintName=UQ_Bugfi...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_10::hp
--  Pre-seeded template groups for sample bugtracker plugins
INSERT INTO bugfieldtemplategroup (name, `description`, bugTrackerPluginId) VALUES ('Bugzilla', 'templates for Bugzilla text fields', 'com.fortify.sample.bugtracker.bugzilla.Bugzilla4BugTrackerPlugin');

INSERT INTO bugfieldtemplategroup (name, `description`, bugTrackerPluginId) VALUES ('JIRA', 'templates for JIRA (legacy plugin using SOAP api) text fields', 'com.fortify.sample.defecttracking.jira.Jira4BugTrackerPlugin');

INSERT INTO bugfieldtemplategroup (name, `description`, bugTrackerPluginId) VALUES ('JIRA 7', 'templates for JIRA 7 (plugin using REST api) text fields', 'com.fortify.pub.bugtracker.plugin.jira.JiraBatchBugTrackerPlugin');

INSERT INTO bugfieldtemplategroup (name, `description`, bugTrackerPluginId) VALUES ('HPE ALM', 'templates for HPE ALM text fields', 'com.fortify.sample.bugtracker.alm.AlmBugTrackerPlugin');

INSERT INTO bugfieldtemplategroup (name, `description`, bugTrackerPluginId) VALUES ('TFS/Visual Studio Online', 'templates for TFS/Visual Studio Online text fields', 'com.fortify.pub.bugtracker.plugin.tfs.TFSBatchBugTrackerPlugin');

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_10', 'hp', 'dbF360_16.20.xml', NOW(), 463, '8:9e5dca4c8dc50dcfdcd53398ed3d0053', 'insert tableName=bugfieldtemplategroup; insert tableName=bugfieldtemplategroup; insert tableName=bugfieldtemplategroup; insert tableName=bugfieldtemplategroup; insert tableName=bugfieldtemplategroup', 'Pre-seeded template groups for sample bugtracker plugins', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_11::hp
--  Information about Audit Assistant status for each project version
CREATE TABLE auditassistantstatus (projectVersion_id BIGINT NOT NULL, userName VARCHAR(255) NULL, fprFilePath VARCHAR(255) NULL, status VARCHAR(80) DEFAULT 'NONE' NULL, serverId BIGINT NULL, serverStatus INT NULL, serverStatusCheckCount INT DEFAULT 0 NULL, message VARCHAR(2000) NULL, lastTrainingTime datetime NULL, CONSTRAINT PK_AUDITASSISTANTSTATUS PRIMARY KEY (projectVersion_id));

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_11', 'hp', 'dbF360_16.20.xml', NOW(), 465, '8:6b2e10e5dd16524882816b0820286ac4', 'createTable tableName=auditassistantstatus', 'Information about Audit Assistant status for each project version', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_12::hp
--  Flag that should be used to mark values that mean "not an issue".
ALTER TABLE attrlookup ADD consideredIssue VARCHAR(1) DEFAULT 'N' NULL;

UPDATE attrlookup SET consideredIssue = 'N';

UPDATE attrlookup SET consideredIssue = 'Y' WHERE attrGuid = '87f2364f-dcd4-49e6-861d-f8d3f351686b' and lookupIndex between 3 and 4;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_12', 'hp', 'dbF360_16.20.xml', NOW(), 467, '8:3506bb950d548ad1be942a790f7f4ac8', 'addColumn tableName=attrlookup; update tableName=attrlookup; update tableName=attrlookup', 'Flag that should be used to mark values that mean "not an issue".', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_13::hp
CREATE UNIQUE INDEX AuditHistoryIssueAltKey ON audithistory(issue_id, attrGuid, auditTime);

CREATE INDEX AuditHistoryPVAltKey ON audithistory(projectVersion_id, attrGuid, auditTime);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_13', 'hp', 'dbF360_16.20.xml', NOW(), 469, '8:c1530705213d3683cd0d4a5e0c252cea', 'createIndex indexName=AuditHistoryIssueAltKey, tableName=audithistory; createIndex indexName=AuditHistoryPVAltKey, tableName=audithistory', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_14::hp
DROP TABLE audithistory_old;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_14', 'hp', 'dbF360_16.20.xml', NOW(), 471, '8:c6a6c7b08221ca8dc5412a5ac908d630', 'dropTable tableName=audithistory_old', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_15::hp
CREATE VIEW audithistoryview AS SELECT h.issue_id  issue_id,
                   h.seqNumber seqNumber,
                   h.attrGuid attrGuid,
                   h.auditTime auditTime,
                   h.oldValue oldValue,
                   h.newValue newValue,
                   h.projectVersion_id projectVersion_id,
                   h.userName userName,
                   h.conflict conflict,
                   a.attrName attrName,
                   a.defaultValue defaultValue
            from audithistory h
            JOIN attr a ON h.attrGuid=a.guid;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_15', 'hp', 'dbF360_16.20.xml', NOW(), 473, '8:f6e8234be3e7a6e8ad1d99184051e570', 'createView viewName=audithistoryview', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_16::hp
--  BIRT temporary directory
INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, appliedAfterRestarting, propertyOrder) VALUES ('birt.report', 'birt.report.tmpDir', '', 'A custum BIRT tmp directory (the default one is taken from JVM system variable java.io.tmpdir ).', 'STRING', 'N', 60);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_16', 'hp', 'dbF360_16.20.xml', NOW(), 475, '8:bd08e3c85b59d081c3a2b0ccb22e2e07', 'insert tableName=configproperty', 'BIRT temporary directory', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_17::hp
--  bugtrackertemplate table is now obsolete
DROP TABLE bugtrackertemplate;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_17', 'hp', 'dbF360_16.20.xml', NOW(), 477, '8:3e7d368a4ee7dfac77640ded72772fbc', 'dropTable tableName=bugtrackertemplate', 'bugtrackertemplate table is now obsolete', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_16.20.xml::f360_16.20_18::hp
INSERT INTO configproperty (groupName, propertyName, propertyValue, `description`, propertyType, appliedAfterRestarting, groupSwitch, required) VALUES ('x509', 'x509.enabled', 'false', 'X.509 Integration', 'BOOLEAN', 'Y', 'Y', 'N');

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_16.20_18', 'hp', 'dbF360_16.20.xml', NOW(), 479, '8:63aace6edfa49eba4487b57defc56aae', 'insert tableName=configproperty', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_Data_16.20.xml::f360_Data_16.20_1::hp
--  Pre-seeded Velocity templates for sample bugtracker plugins (standard newline using backslash n)
INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'Bugzilla'), 'Bug Summary', 'Fix #if ($issues.size() == 1) $issues.get(0).get("ATTRIBUTE_CATEGORY") in $issues.get(0).get("ATTRIBUTE_FILE") #else $ATTRIBUTE_CATEGORY #end \n##This pre-defined template renders a single line for "Bug Summary" ');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'Bugzilla'), 'Bug Description', '#macro( addcontent $attrib )   \n  #if ($is.get($attrib)) $is.get($attrib) $newline $newline #end    \n#end  \n  \n$newline  \n#if ($issues.size() == 1)   \n    #set ($is = $issues.get(0))  \n    #addcontent("ISSUE_DESCRIPTION")  \n    Issue Link: #addcontent("ISSUE_DEEPLINK")  \n    Issue Instance Id: #addcontent("ATTRIBUTE_INSTANCE_ID")  \n    File Name:  #addcontent("ATTRIBUTE_FILE")  \n    Line Number: #addcontent("ATTRIBUTE_LINE")  \n    Issue Category: #addcontent("ATTRIBUTE_CATEGORY")  \n    Application Name: #addcontent("PROJECT_NAME")  \n    Application Version Name: #addcontent("PROJECTVERSION_NAME") \n    Custom Tags: #addcontent("ISSUE_CUSTOMTAGS") \n    Issue Detail: #addcontent("ISSUE_DETAIL") \n    Issue Recommendation: #addcontent("ISSUE_RECOMMENDATION") \n    Comments: #addcontent("ATTRIBUTE_COMMENTS")  \n\n#else \n  Issue Listing \n  $newline \n  #foreach( $is in $issues ) \n    Issue Link:  $is.get("ISSUE_DEEPLINK") $newline File Name: $is.get("ATTRIBUTE_FILE") $newline $newline \n  #end \n\n#end \n##This is the pre-defined velocity template for "Bug Description".  \n##Use the SSC Administration page to manage or customize bugfield templates.');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'JIRA'), 'Bug Summary', 'Fix #if ($issues.size() == 1) $issues.get(0).get("ATTRIBUTE_CATEGORY") in $issues.get(0).get("ATTRIBUTE_FILE") #else $ATTRIBUTE_CATEGORY #end \n##This pre-defined template renders a single line for "Bug Summary" ');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'JIRA'), 'Bug Description', '#macro( addcontent $attrib )   \n  #if ($is.get($attrib)) $is.get($attrib) $newline $newline #end    \n#end  \n  \n$newline  \n#if ($issues.size() == 1)   \n    #set ($is = $issues.get(0))  \n    #addcontent("ISSUE_DESCRIPTION")  \n    Issue Link: #addcontent("ISSUE_DEEPLINK")  \n    Issue Instance Id: #addcontent("ATTRIBUTE_INSTANCE_ID")  \n    File Name:  #addcontent("ATTRIBUTE_FILE")  \n    Line Number: #addcontent("ATTRIBUTE_LINE")  \n    Issue Category: #addcontent("ATTRIBUTE_CATEGORY")  \n    Application Name: #addcontent("PROJECT_NAME")  \n    Application Version Name: #addcontent("PROJECTVERSION_NAME") \n    Custom Tags: #addcontent("ISSUE_CUSTOMTAGS") \n    Issue Detail: #addcontent("ISSUE_DETAIL") \n    Issue Recommendation: #addcontent("ISSUE_RECOMMENDATION") \n    Comments: #addcontent("ATTRIBUTE_COMMENTS")  \n\n#else \n  Issue Listing \n  $newline \n  #foreach( $is in $issues ) \n    Issue Link:  $is.get("ISSUE_DEEPLINK") $newline File Name: $is.get("ATTRIBUTE_FILE") $newline $newline \n  #end \n\n#end \n##This is the pre-defined velocity template for "Bug Description".  \n##Use the SSC Administration page to manage or customize bugfield templates.');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'JIRA 7'), 'Summary', 'Fix #if ($issues.size() == 1) $issues.get(0).get("ATTRIBUTE_CATEGORY") in $issues.get(0).get("ATTRIBUTE_FILE") #else $ATTRIBUTE_CATEGORY #end \n##This pre-defined template renders a single line for "Summary" ');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'JIRA 7'), 'Description', '#macro( addcontent $attrib )   \n  #if ($is.get($attrib)) $is.get($attrib) $newline $newline #end    \n#end  \n  \n$newline  \n#if ($issues.size() == 1)   \n    #set ($is = $issues.get(0))  \n    #addcontent("ISSUE_DESCRIPTION")  \n    Issue Link: #addcontent("ISSUE_DEEPLINK")  \n    Issue Instance Id: #addcontent("ATTRIBUTE_INSTANCE_ID")  \n    File Name:  #addcontent("ATTRIBUTE_FILE")  \n    Line Number: #addcontent("ATTRIBUTE_LINE")  \n    Issue Category: #addcontent("ATTRIBUTE_CATEGORY")  \n    Application Name: #addcontent("PROJECT_NAME")  \n    Application Version Name: #addcontent("PROJECTVERSION_NAME") \n    Custom Tags: #addcontent("ISSUE_CUSTOMTAGS") \n    Issue Detail: #addcontent("ISSUE_DETAIL") \n    Issue Recommendation: #addcontent("ISSUE_RECOMMENDATION") \n    Comments: #addcontent("ATTRIBUTE_COMMENTS")  \n\n#else \n  Issue Listing \n  $newline \n  #foreach( $is in $issues ) \n    Issue Link:  $is.get("ISSUE_DEEPLINK") $newline File Name: $is.get("ATTRIBUTE_FILE") $newline $newline \n  #end \n\n#end \n##This is the pre-defined velocity template for "Description".  \n##Use the SSC Administration page to manage or customize bugfield templates.');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'HPE ALM'), 'Summary', 'Fix #if ($issues.size() == 1) $issues.get(0).get("ATTRIBUTE_CATEGORY") in $issues.get(0).get("ATTRIBUTE_FILE") #else $ATTRIBUTE_CATEGORY #end \n##This pre-defined template renders a single line for "Summary" ');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'HPE ALM'), 'Description', '#macro( addcontent $attrib )   \n  #if ($is.get($attrib)) $is.get($attrib) $newline $newline #end    \n#end  \n  \n$newline  \n#if ($issues.size() == 1)   \n    #set ($is = $issues.get(0))  \n    #addcontent("ISSUE_DESCRIPTION")  \n    Issue Link: #addcontent("ISSUE_DEEPLINK")  \n    Issue Instance Id: #addcontent("ATTRIBUTE_INSTANCE_ID")  \n    File Name:  #addcontent("ATTRIBUTE_FILE")  \n    Line Number: #addcontent("ATTRIBUTE_LINE")  \n    Issue Category: #addcontent("ATTRIBUTE_CATEGORY")  \n    Application Name: #addcontent("PROJECT_NAME")  \n    Application Version Name: #addcontent("PROJECTVERSION_NAME") \n    Custom Tags: #addcontent("ISSUE_CUSTOMTAGS") \n    Issue Detail: #addcontent("ISSUE_DETAIL") \n    Issue Recommendation: #addcontent("ISSUE_RECOMMENDATION") \n    Comments: #addcontent("ATTRIBUTE_COMMENTS")  \n\n#else \n  Issue Listing \n  $newline \n  #foreach( $is in $issues ) \n    Issue Link:  $is.get("ISSUE_DEEPLINK") $newline File Name: $is.get("ATTRIBUTE_FILE") $newline $newline \n  #end \n\n#end \n##This is the pre-defined velocity template for "Description".  \n##Use the SSC Administration page to manage or customize bugfield templates.');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'TFS/Visual Studio Online'), 'Title', 'Fix #if ($issues.size() == 1) $issues.get(0).get("ATTRIBUTE_CATEGORY") in $issues.get(0).get("ATTRIBUTE_FILE") #else $ATTRIBUTE_CATEGORY #end \n##This pre-defined template renders a single line for "Title" ');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'TFS/Visual Studio Online'), 'Description', '#set($linefeed = $newline) \n#set($newline = $linebreak) \n#macro( addcontent $attrib )   \n  #if ($is.get($attrib)) $is.get($attrib) $newline $newline  #end    \n#end  \n  \n$newline  \n#if ($issues.size() == 1)   \n    #set ($is = $issues.get(0))  \n    #addcontent("ISSUE_DESCRIPTION")  \n    Issue Link: #addcontent("ISSUE_DEEPLINK")  \n    Issue Instance Id: #addcontent("ATTRIBUTE_INSTANCE_ID")  \n    File Name:  #addcontent("ATTRIBUTE_FILE")  \n    Line Number: #addcontent("ATTRIBUTE_LINE")  \n    Issue Category: #addcontent("ATTRIBUTE_CATEGORY")  \n    Application Name: #addcontent("PROJECT_NAME")  \n    Application Version Name: #addcontent("PROJECTVERSION_NAME") \n    Custom Tags: #addcontent("ISSUE_CUSTOMTAGS") \n    Issue Detail: #addcontent("ISSUE_DETAIL") \n    Issue Recommendation: #addcontent("ISSUE_RECOMMENDATION") \n    Comments: #if ($is.get("ATTRIBUTE_COMMENTS")) $is.get("ATTRIBUTE_COMMENTS").replace($linefeed, $linebreak) #end  \n\n#else \n  Issue Listing \n  $newline $newline \n  #foreach( $is in $issues ) \n    Issue Link:  $is.get("ISSUE_DEEPLINK") $newline File Name: $is.get("ATTRIBUTE_FILE") $newline $newline \n  #end \n\n#end \n##This is the pre-defined velocity template for "Description".  \n##Use the SSC Administration page to manage or customize bugfield templates.');

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_Data_16.20_1', 'hp', 'dbF360_Data_16.20.xml', NOW(), 481, '8:425618efe9637a15552d5d6df1e13b42', 'sql; sql; sql; sql; sql; sql; sql; sql; sql; sql', 'Pre-seeded Velocity templates for sample bugtracker plugins (standard newline using backslash n)', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10_auditcomment.xml::f360_17.10_auditcomment_1::hp
DROP INDEX AuditCommentAltKey ON auditcomment;

ALTER TABLE auditcomment RENAME auditcomment_old;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_auditcomment_1', 'hp', 'dbF360_17.10_auditcomment.xml', NOW(), 483, '8:f4b2d2df4e269d7a5256288c87095338', 'dropIndex indexName=AuditCommentAltKey, tableName=auditcomment; renameTable newTableName=auditcomment_old, oldTableName=auditcomment', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10_auditcomment.xml::f360_17.10_auditcomment_3::hp
CREATE TABLE auditcomment (issue_id BIGINT NOT NULL, seqNumber BIGINT NOT NULL, auditTime BIGINT NULL, commentText MEDIUMTEXT NULL, userName VARCHAR(255) NULL, CONSTRAINT PK_AUDITCOMMENT PRIMARY KEY (issue_id, seqNumber));

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_auditcomment_3', 'hp', 'dbF360_17.10_auditcomment.xml', NOW(), 485, '8:d683805ee953a10756a766d834f0216b', 'createTable tableName=auditcomment', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_17.10_auditcomment.xml::f360Mysql_17.10_0::hp
--  Audit comment value migration
INSERT INTO auditcomment (`issue_id`, `seqNumber`, `auditTime`, `commentText`, `userName`)
            SELECT `issue_id`, `seqNumber`, `auditTime`, `commentText`, `userName`
            FROM auditcomment_old;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_17.10_0', 'hp', 'dbF360Mysql_17.10_auditcomment.xml', NOW(), 487, '8:19f3c359c1c008ba31630b4aa42f5c2e', 'sql', 'Audit comment value migration', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_1::hp
ALTER TABLE snapshot ADD artifact_id BIGINT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_1', 'hp', 'dbF360_17.10.xml', NOW(), 489, '8:f7b8ba7564df67a4846a56dc2ccc2978', 'addColumn tableName=snapshot', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_2::hp
ALTER TABLE alert ADD customMessage VARCHAR(2000) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_2', 'hp', 'dbF360_17.10.xml', NOW(), 491, '8:c70c65ff4a3207ed7aa5e547235c3188', 'addColumn tableName=alert', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_3::hp
ALTER TABLE alerthistory ADD customMessage VARCHAR(2000) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_3', 'hp', 'dbF360_17.10.xml', NOW(), 493, '8:480b1891093fa914f8fc2189ea3cddfe', 'addColumn tableName=alerthistory', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_4::hp
CREATE TABLE scan_issue_ca (projectVersion_id BIGINT NOT NULL, scan_id BIGINT NOT NULL, scan_issue_id BIGINT NOT NULL, dataVersion INT NOT NULL, integerValue01 INT NULL, integerValue02 INT NULL, integerValue03 INT NULL, decimalValue01 DECIMAL(18, 9) NULL, decimalValue02 DECIMAL(18, 9) NULL, decimalValue03 DECIMAL(18, 9) NULL, decimalValue04 DECIMAL(18, 9) NULL, decimalValue05 DECIMAL(18, 9) NULL, dateValue01 date NULL, dateValue02 date NULL, dateValue03 date NULL, dateValue04 date NULL, dateValue05 date NULL, textValue01 VARCHAR(1000) NULL, textValue02 VARCHAR(1000) NULL, textValue03 VARCHAR(1000) NULL, textValue04 VARCHAR(1000) NULL, textValue05 VARCHAR(1000) NULL, textValue06 VARCHAR(1000) NULL, textValue07 VARCHAR(1000) NULL, textValue08 VARCHAR(1000) NULL, textValue09 VARCHAR(1000) NULL, textValue10 VARCHAR(1000) NULL, textValue11 VARCHAR(1000) NULL, textValue12 VARCHAR(1000) NULL, clobValue01 MEDIUMTEXT NULL, clobValue02 MEDIUMTEXT NULL, CONSTRAINT PK_SCAN_ISSUE_CA PRIMARY KEY (scan_issue_id));

CREATE INDEX SCAN_ISSUE_CA_PV_SCAN_ID_IDX ON scan_issue_ca(projectVersion_id, scan_id, scan_issue_id);

CREATE TABLE issue_ca (issue_id BIGINT NOT NULL, projectVersion_id BIGINT NOT NULL, issueInstanceId VARCHAR(80) NOT NULL, engineType VARCHAR(20) NOT NULL, dataVersion INT NOT NULL, integerValue01 INT NULL, integerValue02 INT NULL, integerValue03 INT NULL, decimalValue01 DECIMAL(18, 9) NULL, decimalValue02 DECIMAL(18, 9) NULL, decimalValue03 DECIMAL(18, 9) NULL, decimalValue04 DECIMAL(18, 9) NULL, decimalValue05 DECIMAL(18, 9) NULL, dateValue01 date NULL, dateValue02 date NULL, dateValue03 date NULL, dateValue04 date NULL, dateValue05 date NULL, textValue01 VARCHAR(1000) NULL, textValue02 VARCHAR(1000) NULL, textValue03 VARCHAR(1000) NULL, textValue04 VARCHAR(1000) NULL, textValue05 VARCHAR(1000) NULL, textValue06 VARCHAR(1000) NULL, textValue07 VARCHAR(1000) NULL, textValue08 VARCHAR(1000) NULL, textValue09 VARCHAR(1000) NULL, textValue10 VARCHAR(1000) NULL, textValue11 VARCHAR(1000) NULL, textValue12 VARCHAR(1000) NULL, clobValue01 MEDIUMTEXT NULL, clobValue02 MEDIUMTEXT NULL, CONSTRAINT PK_ISSUE_CA PRIMARY KEY (issue_id));

CREATE INDEX ISSUE_ATTR_PV_ISSUE_ID_IDX ON issue_ca(projectVersion_id, issue_id);

CREATE TABLE parserpluginmetadata (id BIGINT AUTO_INCREMENT NOT NULL, pluginId VARCHAR(80) NOT NULL, apiVersion VARCHAR(8) NOT NULL, pluginName VARCHAR(40) NOT NULL, pluginVersion VARCHAR(25) NOT NULL, dataVersion INT NOT NULL, vendorName VARCHAR(80) NOT NULL, vendorUrl VARCHAR(100) NULL, engineType VARCHAR(80) NOT NULL, `description` VARCHAR(500) NULL, CONSTRAINT PK_PARSERPLUGINMETADATA PRIMARY KEY (id));

CREATE UNIQUE INDEX PLUGIN_META_DATA_ID_VERS_IDX ON parserpluginmetadata(pluginId, pluginVersion);

CREATE TABLE pluginimage (metadataPluginId VARCHAR(80) NOT NULL, imageType VARCHAR(16) NOT NULL, imageData MEDIUMBLOB NULL, CONSTRAINT PK_PLUGINIMAGE PRIMARY KEY (metadataPluginId, imageType));

CREATE TABLE pluginconfiguration (metadataId BIGINT NOT NULL, parameterName VARCHAR(30) NOT NULL, parameterType VARCHAR(10) NOT NULL, CONSTRAINT PK_PLUGINCONFIGURATION PRIMARY KEY (metadataId, parameterName));

CREATE TABLE pluginlocalization (metadataId BIGINT NOT NULL, languageId VARCHAR(10) NOT NULL, localizationData MEDIUMBLOB NOT NULL, CONSTRAINT PK_PLUGINLOCALIZATION PRIMARY KEY (metadataId, languageId));

CREATE TABLE issuemetadata (id BIGINT AUTO_INCREMENT NOT NULL, engineType VARCHAR(80) NOT NULL, dataVersion INT NOT NULL, attribute_id VARCHAR(50) NOT NULL, attributeDataType VARCHAR(30) NOT NULL, dataColumnName VARCHAR(32) NOT NULL, CONSTRAINT PK_ISSUEMETADATA PRIMARY KEY (id));

CREATE INDEX ISSUE_META_DATA_ET_DV_IDX ON issuemetadata(engineType, dataVersion);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_4', 'hp', 'dbF360_17.10.xml', NOW(), 495, '8:537dfd48597ac2b3582d64fa3d8059fc', 'createTable tableName=scan_issue_ca; createIndex indexName=SCAN_ISSUE_CA_PV_SCAN_ID_IDX, tableName=scan_issue_ca; createTable tableName=issue_ca; createIndex indexName=ISSUE_ATTR_PV_ISSUE_ID_IDX, tableName=issue_ca; createTable tableName=parserplu...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_5::hp
--  Remove FK constraint RefAppEntEventLog - not used anywhere, elimination of possible deadlocks
ALTER TABLE eventlogentry DROP FOREIGN KEY RefAppEntEventLog;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_5', 'hp', 'dbF360_17.10.xml', NOW(), 497, '8:1a519d24f8f7feb83f3afd11d51b0532', 'dropForeignKeyConstraint baseTableName=eventlogentry, constraintName=RefAppEntEventLog', 'Remove FK constraint RefAppEntEventLog - not used anywhere, elimination of possible deadlocks', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_6::hp
CREATE TABLE issueviewtemplate (id INT AUTO_INCREMENT NOT NULL, engineType VARCHAR(20) NOT NULL, dataVersion INT NOT NULL, templateData MEDIUMBLOB NULL, objectVersion INT NOT NULL, `description` VARCHAR(250) NULL, CONSTRAINT PK_ISSUEVIEWTEMPLATE PRIMARY KEY (id));

CREATE UNIQUE INDEX ISSUE_VIEW_TPL_ENGINE_VERS_IDX ON issueviewtemplate(engineType, dataVersion);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_6', 'hp', 'dbF360_17.10.xml', NOW(), 499, '8:3718a7411cf7ca7747312830983d9e29', 'createTable tableName=issueviewtemplate; createIndex indexName=ISSUE_VIEW_TPL_ENGINE_VERS_IDX, tableName=issueviewtemplate', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_7::hp
--  Audit Assistant training status for each project version
CREATE TABLE auditassistanttrainingstatus (projectVersion_id BIGINT NOT NULL, userName VARCHAR(255) NULL, status VARCHAR(80) DEFAULT 'NONE' NULL, lastTrainingTime datetime NULL, message VARCHAR(2000) NULL, CONSTRAINT PK_AATRAININGSTATUS PRIMARY KEY (projectVersion_id));

ALTER TABLE auditassistantstatus DROP COLUMN lastTrainingTime;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_7', 'hp', 'dbF360_17.10.xml', NOW(), 501, '8:90a242a33c21825edcdbb6ca12549e31', 'createTable tableName=auditassistanttrainingstatus; dropColumn columnName=lastTrainingTime, tableName=auditassistantstatus', 'Audit Assistant training status for each project version', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_8::hp
ALTER TABLE ldapserver ADD checkSslTrust VARCHAR(1) DEFAULT 'Y' NOT NULL, ADD checkSslHostname VARCHAR(1) DEFAULT 'N' NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_8', 'hp', 'dbF360_17.10.xml', NOW(), 503, '8:9654027860437ae402bcf3432c7b300a', 'addColumn tableName=ldapserver', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_9::hp
--  Add non unique index on eventDate field
CREATE INDEX EVENTLOGENTRY_EVENTDATE_IDX ON eventlogentry(eventDate);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_9', 'hp', 'dbF360_17.10.xml', NOW(), 505, '8:6f9c9170e65d21de5b9dfeca06adb407', 'createIndex indexName=EVENTLOGENTRY_EVENTDATE_IDX, tableName=eventlogentry', 'Add non unique index on eventDate field', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_10::hp
--  Value provided by issue parser and contains a numeric data version of the issue data parsed by plugin.
ALTER TABLE scan ADD dataVersion INT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_10', 'hp', 'dbF360_17.10.xml', NOW(), 507, '8:f4f7032f28ec319656ebb209f3a1b819', 'addColumn tableName=scan', 'Value provided by issue parser and contains a numeric data version of the issue data parsed by plugin.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_11::hp
--  Engine type of tha scan in artifact. Value of the field is null if artifact contains multiply scans.
ALTER TABLE artifact ADD engineType VARCHAR(20) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_11', 'hp', 'dbF360_17.10.xml', NOW(), 509, '8:5f7e61fa04a4c43e553c174b09ba471c', 'addColumn tableName=artifact', 'Engine type of tha scan in artifact. Value of the field is null if artifact contains multiply scans.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_12::hp
ALTER TABLE alerttrigger ADD resetAfterTriggering VARCHAR(1) DEFAULT 'N' NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_12', 'hp', 'dbF360_17.10.xml', NOW(), 511, '8:d470ea5c4d0b74097f45b13d6b6d2fcd', 'addColumn tableName=alerttrigger', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_13::hp
CREATE UNIQUE INDEX AuditCommentAltKey ON auditcomment(issue_id, auditTime);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_13', 'hp', 'dbF360_17.10.xml', NOW(), 513, '8:54647a4895b235e81d0d4ea3b3eddcda', 'createIndex indexName=AuditCommentAltKey, tableName=auditcomment', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_14::hp
DROP TABLE auditcomment_old;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_14', 'hp', 'dbF360_17.10.xml', NOW(), 515, '8:0879d78ce51826b9bfa16d7724879078', 'dropTable tableName=auditcomment_old', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_15::hp
--  some formatting tweaks for velocity templates: replace newlines with linebreak for html, remove prefix spaces introduced by addcontent macro and a few others
UPDATE bugfieldtemplate SET fieldValue = REPLACE(fieldValue, 'Custom Tags: #addcontent', 'Custom Tags: $newline#addcontent');

UPDATE bugfieldtemplate SET fieldValue = REPLACE(fieldValue, 'Comments: #', 'Comments: $newline#');

UPDATE bugfieldtemplate SET fieldValue = REPLACE(fieldValue, 'Issue Recommendation: #addcontent', 'Issue Recommendation: $newline#addcontent');

UPDATE bugfieldtemplate SET fieldValue = REPLACE(fieldValue, '#macro( addcontent $attrib )   ', '#macro( addcontent $attrib )');

UPDATE bugfieldtemplate SET fieldValue = REPLACE(fieldValue, '  #if ($is.get($attrib)) $is.get($attrib)', '#if($is.get($attrib))$is.get($attrib)');

UPDATE bugfieldtemplate SET fieldValue = REPLACE(fieldValue, '#if($is.get($attrib))$is.get($attrib) ', '#if($is.get($attrib))$is.get($attrib).replace($linefeed, $linebreak) ') WHERE fieldValue LIKE '%#set($linefeed = $newline)%';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_15', 'hp', 'dbF360_17.10.xml', NOW(), 517, '8:052475178c8e611b3a26543073d38ea8', 'sql; sql; sql; sql; sql; sql', 'some formatting tweaks for velocity templates: replace newlines with linebreak for html, remove prefix spaces introduced by addcontent macro and a few others', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.10.xml::f360_17.10_16::hp
--  Change "value" column of usersessionstate table to a CLOB datatype
CREATE TABLE usersessionstate_temp (id INT AUTO_INCREMENT NOT NULL, userName VARCHAR(255) NOT NULL, name VARCHAR(255) NULL, value MEDIUMTEXT NULL, category VARCHAR(100) NULL, projectVersionId INT NULL, CONSTRAINT PK_USERSESSIONSTATE PRIMARY KEY (id));

INSERT INTO usersessionstate_temp (userName, name, value, category, projectVersionId)
            SELECT userName, name, value, category, projectVersionId FROM usersessionstate;

DROP TABLE usersessionstate;

ALTER TABLE usersessionstate_temp RENAME usersessionstate;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.10_16', 'hp', 'dbF360_17.10.xml', NOW(), 519, '8:3814d1923f00d6adade689e1f4e7884c', 'createTable tableName=usersessionstate_temp; sql; dropTable tableName=usersessionstate; renameTable newTableName=usersessionstate, oldTableName=usersessionstate_temp', 'Change "value" column of usersessionstate table to a CLOB datatype', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_1::hp
ALTER TABLE parserpluginmetadata ADD supportedEngineVersions VARCHAR(40) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_1', 'hp', 'dbF360_17.20.xml', NOW(), 521, '8:39735240f6ebc144f20bf0fc74fa521a', 'addColumn tableName=parserpluginmetadata', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_2::hp
ALTER TABLE configproperty MODIFY propertyType VARCHAR(25);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_2', 'hp', 'dbF360_17.20.xml', NOW(), 523, '8:d0b16a2bde13f1eb633d6093e38758b6', 'modifyDataType columnName=propertyType, tableName=configproperty', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_3::hp
ALTER TABLE parserpluginmetadata RENAME pluginmetadata;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_3', 'hp', 'dbF360_17.20.xml', NOW(), 525, '8:980956f4fd5632a76ccf3bd22fe416d7', 'renameTable newTableName=pluginmetadata, oldTableName=parserpluginmetadata', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_4::hp
ALTER TABLE pluginmetadata ADD pluginType VARCHAR(25) NULL, ADD lastAction VARCHAR(25) NULL, ADD documentInfo_id INT NULL;

UPDATE pluginmetadata SET pluginType = 'SCAN_PARSER';

CREATE INDEX IDX_PLUGINMETADATA_DOC_ID ON pluginmetadata(documentInfo_id);

ALTER TABLE pluginmetadata ADD CONSTRAINT RefDocInfoPluginMetaData FOREIGN KEY (documentInfo_id) REFERENCES documentinfo (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_4', 'hp', 'dbF360_17.20.xml', NOW(), 527, '8:a573eb4c9be32bbe4351659f15774264', 'addColumn tableName=pluginmetadata; createIndex indexName=IDX_PLUGINMETADATA_DOC_ID, tableName=pluginmetadata; addForeignKeyConstraint baseTableName=pluginmetadata, constraintName=RefDocInfoPluginMetaData, referencedTableName=documentinfo', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_5::hp
--  Table for info regarding data exported in CSV format by default. File with exported data is stored as a blob in datablob table.
CREATE TABLE dataexport (id BIGINT AUTO_INCREMENT NOT NULL, datasetName VARCHAR(50) NOT NULL, fileName VARCHAR(255) NOT NULL, fileType VARCHAR(10) DEFAULT 'CSV' NULL, note VARCHAR(255) NULL, exportDate datetime NOT NULL, userName VARCHAR(255) NOT NULL, status VARCHAR(30) NOT NULL, documentInfo_id INT NULL, projectVersion_id BIGINT NULL, CONSTRAINT PK_DATAEXPORT PRIMARY KEY (id));

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_5', 'hp', 'dbF360_17.20.xml', NOW(), 529, '8:33885e81c8bbf2b55cc5080288eec085', 'createTable tableName=dataexport', 'Table for info regarding data exported in CSV format by default. File with exported data is stored as a blob in datablob table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_6::hp
ALTER TABLE pluginmetadata MODIFY engineType VARCHAR(80) NULL;

ALTER TABLE pluginmetadata ADD lastUsedOfKind VARCHAR(1) DEFAULT 'N' NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_6', 'hp', 'dbF360_17.20.xml', NOW(), 531, '8:4e58083c91a2664d200b188ec7ebb723', 'dropNotNullConstraint columnName=engineType, tableName=pluginmetadata; addColumn tableName=pluginmetadata', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_7::hp
--  Switching issuemetadata identification from engine type + data version to meta data ID.
CREATE TABLE issuemetadata_temp (id BIGINT AUTO_INCREMENT NOT NULL, metadataId BIGINT NOT NULL, attribute_id VARCHAR(50) NOT NULL, attributeDataType VARCHAR(30) NOT NULL, dataColumnName VARCHAR(32) NOT NULL, CONSTRAINT PK_ISSUEMETADATA_TEMP PRIMARY KEY (id, metadataId));

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_7', 'hp', 'dbF360_17.20.xml', NOW(), 533, '8:92f6e95b2620790f7d45c870b59db64c', 'createTable tableName=issuemetadata_temp', 'Switching issuemetadata identification from engine type + data version to meta data ID.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_7_2::hp
INSERT INTO issuemetadata_temp (metadataId, attribute_id, attributeDataType, dataColumnName)
            SELECT (SELECT max(pm.id) FROM pluginmetadata pm where imt.engineType = pm.engineType and imt.dataVersion = pm.dataVersion) as metadataId,
                   imt.attribute_id,
                   imt.attributeDataType,
                   imt.dataColumnName
            FROM issuemetadata imt
            WHERE EXISTS (SELECT pm.id FROM pluginmetadata pm WHERE imt.engineType = pm.engineType and imt.dataVersion = pm.dataVersion);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_7_2', 'hp', 'dbF360_17.20.xml', NOW(), 535, '8:1b09fda4fe5bf047baf931e5ecd43a9a', 'sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_7_3::hp
DROP TABLE issuemetadata;

ALTER TABLE issuemetadata_temp RENAME issuemetadata;

CREATE INDEX ISSUE_META_DATA_MD_ID_IDX ON issuemetadata(metadataId);

ALTER TABLE issuemetadata ADD CONSTRAINT RefIssueMetadataPlugMetadata FOREIGN KEY (metadataId) REFERENCES pluginmetadata (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_7_3', 'hp', 'dbF360_17.20.xml', NOW(), 537, '8:6a0892dbe4cef511346768b896f8be30', 'dropTable tableName=issuemetadata; renameTable newTableName=issuemetadata, oldTableName=issuemetadata_temp; createIndex indexName=ISSUE_META_DATA_MD_ID_IDX, tableName=issuemetadata; addForeignKeyConstraint baseTableName=issuemetadata, constraintNa...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_8::hp
--  in 17.10, there can only be one entry in pluginmetadata for each engine type
CREATE TABLE issueviewtemplate_temp (id INT AUTO_INCREMENT NOT NULL, metadataId BIGINT NOT NULL, templateData MEDIUMBLOB NULL, objectVersion INT NOT NULL, `description` VARCHAR(250) NULL, CONSTRAINT PK_ISSUEVIEWTEMPLATE_TEMP PRIMARY KEY (id, metadataId));

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_8', 'hp', 'dbF360_17.20.xml', NOW(), 539, '8:998d5a2322eb2fa5a6ef1f509ba345db', 'createTable tableName=issueviewtemplate_temp', 'in 17.10, there can only be one entry in pluginmetadata for each engine type', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_8_2::hp
INSERT INTO issueviewtemplate_temp (metadataId, templateData, objectVersion, description)
            SELECT (SELECT max(pm.id) FROM pluginmetadata pm where ivt.engineType = pm.engineType and ivt.dataVersion = pm.dataVersion) as metadataId,
            ivt.templateData,
            ivt.objectVersion,
            ivt.description
            FROM issueviewtemplate ivt
            WHERE EXISTS (SELECT pm.id FROM pluginmetadata pm WHERE ivt.engineType = pm.engineType and ivt.dataVersion = pm.dataVersion);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_8_2', 'hp', 'dbF360_17.20.xml', NOW(), 541, '8:2839fcb4b1c3dea8d3568676a3e008f3', 'sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_8_3::hp
DROP TABLE issueviewtemplate;

ALTER TABLE issueviewtemplate_temp RENAME issueviewtemplate;

CREATE UNIQUE INDEX ISSUE_VIEW_TPL_MD_ID_IDX ON issueviewtemplate(metadataId);

ALTER TABLE issueviewtemplate ADD CONSTRAINT RefIssueViewTplPlugMetadata FOREIGN KEY (metadataId) REFERENCES pluginmetadata (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_8_3', 'hp', 'dbF360_17.20.xml', NOW(), 543, '8:cd3b9384719a8bb84a7a5dd05343a336', 'dropTable tableName=issueviewtemplate; renameTable newTableName=issueviewtemplate, oldTableName=issueviewtemplate_temp; createIndex indexName=ISSUE_VIEW_TPL_MD_ID_IDX, tableName=issueviewtemplate; addForeignKeyConstraint baseTableName=issueviewtem...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_9::hp
--  Switching plugin image identification from plugin ID to meta data ID.
CREATE TABLE pluginimage_temp (metadataId BIGINT NOT NULL, imageType VARCHAR(16) NOT NULL, imageData MEDIUMBLOB NULL, CONSTRAINT PK_PLUGINIMAGE_TEMP PRIMARY KEY (metadataId, imageType));

INSERT INTO pluginimage_temp (metadataId, imageType, imageData)
            SELECT (SELECT max(pm.id) FROM pluginmetadata pm where metadataPluginId = pm.pluginId) as metadataId,
                   pi.imageType, pi.imageData
            FROM pluginimage pi
            WHERE EXISTS (SELECT pm.id FROM pluginmetadata pm WHERE metadataPluginId = pm.pluginId);

DROP TABLE pluginimage;

ALTER TABLE pluginimage_temp RENAME pluginimage;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_9', 'hp', 'dbF360_17.20.xml', NOW(), 545, '8:a5703c8204b377bba2deb5ba8f7626bb', 'createTable tableName=pluginimage_temp; sql; dropTable tableName=pluginimage; renameTable newTableName=pluginimage, oldTableName=pluginimage_temp', 'Switching plugin image identification from plugin ID to meta data ID.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_10::hp
--  Store pluginID in scan table.
CREATE INDEX PLUGINMETADATA_ET_ID_IDX ON pluginmetadata(engineType, pluginId);

ALTER TABLE scan ADD metadataPluginId VARCHAR(80) NULL;

UPDATE scan SET metadataPluginId =
            (SELECT DISTINCT pluginId FROM pluginmetadata WHERE pluginType = 'SCAN_PARSER' AND engineType = scan.engineType)
            WHERE EXISTS (SELECT 1 from pluginmetadata WHERE engineType = scan.engineType);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_10', 'hp', 'dbF360_17.20.xml', NOW(), 547, '8:6d863b0b2f9961bad3c4c52aea4bf4d1', 'createIndex indexName=PLUGINMETADATA_ET_ID_IDX, tableName=pluginmetadata; addColumn tableName=scan; sql', 'Store pluginID in scan table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_11::hp
--  Migrate scan_issue_ca table: store pluginID and add more column for attributes.
CREATE TABLE scan_issue_ca_temp (projectVersion_id BIGINT NOT NULL, scan_id BIGINT NOT NULL, scan_issue_id BIGINT NOT NULL, metadataPluginId VARCHAR(80) NOT NULL, dataVersion INT NOT NULL, integerValue01 INT NULL, integerValue02 INT NULL, integerValue03 INT NULL, decimalValue01 DECIMAL(18, 9) NULL, decimalValue02 DECIMAL(18, 9) NULL, decimalValue03 DECIMAL(18, 9) NULL, decimalValue04 DECIMAL(18, 9) NULL, decimalValue05 DECIMAL(18, 9) NULL, dateValue01 date NULL, dateValue02 date NULL, dateValue03 date NULL, dateValue04 date NULL, dateValue05 date NULL, textValue01 VARCHAR(800) NULL, textValue02 VARCHAR(800) NULL, textValue03 VARCHAR(800) NULL, textValue04 VARCHAR(800) NULL, textValue05 VARCHAR(800) NULL, textValue06 VARCHAR(800) NULL, textValue07 VARCHAR(800) NULL, textValue08 VARCHAR(800) NULL, textValue09 VARCHAR(800) NULL, textValue10 VARCHAR(800) NULL, textValue11 VARCHAR(800) NULL, textValue12 VARCHAR(800) NULL, textValue13 VARCHAR(800) NULL, textValue14 VARCHAR(800) NULL, textValue15 VARCHAR(800) NULL, textValue16 VARCHAR(800) NULL, clobValue01 MEDIUMTEXT NULL, clobValue02 MEDIUMTEXT NULL, clobValue03 MEDIUMTEXT NULL, clobValue04 MEDIUMTEXT NULL, clobValue05 MEDIUMTEXT NULL, clobValue06 MEDIUMTEXT NULL, CONSTRAINT PK_SCAN_ISSUE_CA_TEMP PRIMARY KEY (scan_issue_id));

INSERT INTO scan_issue_ca_temp (projectVersion_id, scan_id, scan_issue_id, metadataPluginId, dataVersion,
                                            integerValue01, integerValue02, integerValue03,
                                            decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
                                            dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
                                            textValue01, textValue02, textValue03, textValue04,
                                            textValue05, textValue06, textValue07, textValue08,
                                            textValue09, textValue10, textValue11, textValue12,
                                            clobValue01, clobValue02
            )
            SELECT sic.projectVersion_id,
                   sic.scan_id,
                   sic.scan_issue_id,
                   pmt.pluginId,
                   sic.dataVersion,
                   integerValue01, integerValue02, integerValue03,
                   decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
                   dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
                   textValue01, textValue02, textValue03, textValue04,
                   textValue05, textValue06, textValue07, textValue08,
                   textValue09, textValue10, textValue11, textValue12,
                   clobValue01, clobValue02
            FROM scan_issue_ca sic, scan s
            LEFT JOIN (SELECT pmt.pluginId, pmt.engineType FROM pluginmetadata pmt WHERE pluginType = 'SCAN_PARSER' GROUP BY pmt.pluginId, pmt.engineType) pmt ON s.engineType = pmt.engineType
            WHERE sic.scan_id = s.id;

DROP TABLE scan_issue_ca;

ALTER TABLE scan_issue_ca_temp RENAME scan_issue_ca;

CREATE INDEX SCAN_ISSUE_CA_PV_SCAN_ID_IDX ON scan_issue_ca(projectVersion_id, scan_id, scan_issue_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_11', 'hp', 'dbF360_17.20.xml', NOW(), 549, '8:a59bfa08170b0ec228d9a5ed0dd44774', 'createTable tableName=scan_issue_ca_temp; sql; dropTable tableName=scan_issue_ca; renameTable newTableName=scan_issue_ca, oldTableName=scan_issue_ca_temp; createIndex indexName=SCAN_ISSUE_CA_PV_SCAN_ID_IDX, tableName=scan_issue_ca', 'Migrate scan_issue_ca table: store pluginID and add more column for attributes.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_12::hp
--  Migrate issue_ca table: store pluginID and add more column for attributes.
CREATE TABLE issue_ca_temp (issue_id BIGINT NOT NULL, projectVersion_id BIGINT NOT NULL, issueInstanceId VARCHAR(80) NOT NULL, engineType VARCHAR(20) NOT NULL, metadataPluginId VARCHAR(80) NOT NULL, dataVersion INT NOT NULL, integerValue01 INT NULL, integerValue02 INT NULL, integerValue03 INT NULL, decimalValue01 DECIMAL(18, 9) NULL, decimalValue02 DECIMAL(18, 9) NULL, decimalValue03 DECIMAL(18, 9) NULL, decimalValue04 DECIMAL(18, 9) NULL, decimalValue05 DECIMAL(18, 9) NULL, dateValue01 date NULL, dateValue02 date NULL, dateValue03 date NULL, dateValue04 date NULL, dateValue05 date NULL, textValue01 VARCHAR(800) NULL, textValue02 VARCHAR(800) NULL, textValue03 VARCHAR(800) NULL, textValue04 VARCHAR(800) NULL, textValue05 VARCHAR(800) NULL, textValue06 VARCHAR(800) NULL, textValue07 VARCHAR(800) NULL, textValue08 VARCHAR(800) NULL, textValue09 VARCHAR(800) NULL, textValue10 VARCHAR(800) NULL, textValue11 VARCHAR(800) NULL, textValue12 VARCHAR(800) NULL, textValue13 VARCHAR(800) NULL, textValue14 VARCHAR(800) NULL, textValue15 VARCHAR(800) NULL, textValue16 VARCHAR(800) NULL, clobValue01 MEDIUMTEXT NULL, clobValue02 MEDIUMTEXT NULL, clobValue03 MEDIUMTEXT NULL, clobValue04 MEDIUMTEXT NULL, clobValue05 MEDIUMTEXT NULL, clobValue06 MEDIUMTEXT NULL, CONSTRAINT PK_ISSUE_CA_TEMP PRIMARY KEY (issue_id));

INSERT INTO issue_ca_temp (issue_id, projectVersion_id, issueInstanceId, engineType, metadataPluginId, dataVersion,
                                       integerValue01, integerValue02, integerValue03,
                                       decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
                                       dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
                                       textValue01, textValue02, textValue03, textValue04,
                                       textValue05, textValue06, textValue07, textValue08,
                                       textValue09, textValue10, textValue11, textValue12,
                                       clobValue01, clobValue02
            )
            SELECT ic.issue_id,
                   ic.projectVersion_id,
                   ic.issueInstanceId,
                   ic.engineType,
                   pmt.pluginId,
                   ic.dataVersion,
                   integerValue01, integerValue02, integerValue03,
                   decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
                   dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
                   textValue01, textValue02, textValue03, textValue04,
                   textValue05, textValue06, textValue07, textValue08,
                   textValue09, textValue10, textValue11, textValue12,
                   clobValue01, clobValue02
            FROM issue_ca ic
            LEFT JOIN (SELECT pmt.pluginId, pmt.engineType FROM pluginmetadata pmt WHERE pluginType = 'SCAN_PARSER' GROUP BY pmt.pluginId, pmt.engineType) pmt ON ic.engineType = pmt.engineType;

DROP TABLE issue_ca;

ALTER TABLE issue_ca_temp RENAME issue_ca;

CREATE INDEX ISSUE_ATTR_PV_ISSUE_ID_IDX ON issue_ca(projectVersion_id, issue_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_12', 'hp', 'dbF360_17.20.xml', NOW(), 551, '8:46458b10f63b93618cab657e247dc791', 'createTable tableName=issue_ca_temp; sql; dropTable tableName=issue_ca; renameTable newTableName=issue_ca, oldTableName=issue_ca_temp; createIndex indexName=ISSUE_ATTR_PV_ISSUE_ID_IDX, tableName=issue_ca', 'Migrate issue_ca table: store pluginID and add more column for attributes.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_13::hp
ALTER TABLE pluginmetadata MODIFY pluginName VARCHAR(80);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_13', 'hp', 'dbF360_17.20.xml', NOW(), 553, '8:bf8801e2e2f6688daaf2a940be4e7fe2', 'modifyDataType columnName=pluginName, tableName=pluginmetadata', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_14::hp
ALTER TABLE bugfieldtemplategroup DROP KEY UK_BugfieldTemplateGroupName;

ALTER TABLE bugfieldtemplategroup DROP COLUMN name;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_14', 'hp', 'dbF360_17.20.xml', NOW(), 555, '8:5849ed77d9530c9e1f06494492f65143', 'dropUniqueConstraint constraintName=UK_BugfieldTemplateGroupName, tableName=bugfieldtemplategroup; dropColumn columnName=name, tableName=bugfieldtemplategroup', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_15::hp
ALTER TABLE folder ADD orderIndex INT NULL;

UPDATE projectversion SET staleProjectTemplate = 'Y';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_15', 'hp', 'dbF360_17.20.xml', NOW(), 557, '8:ea83dd62cd0f50d6834b06ec5ca2ffcb', 'addColumn tableName=folder; update tableName=projectversion', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_17.20.xml::f360_17.20_16::hp
DELETE FROM pluginimage;

DELETE FROM pluginconfiguration;

DELETE FROM pluginlocalization;

DELETE FROM issueviewtemplate;

DELETE FROM pluginmetadata;

DELETE FROM issuemetadata;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_17.20_16', 'hp', 'dbF360_17.20.xml', NOW(), 559, '8:708e1ef633557e41260a5c36e02cbee4', 'delete tableName=pluginimage; delete tableName=pluginconfiguration; delete tableName=pluginlocalization; delete tableName=issueviewtemplate; delete tableName=pluginmetadata; delete tableName=issuemetadata', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.10.xml::f360_18.10_01::hp
CREATE TABLE projectversionviewoption (projectVersion_id BIGINT NOT NULL, userName VARCHAR(255) NOT NULL, optionName VARCHAR(40) NOT NULL, boolValue VARCHAR(1) NULL, CONSTRAINT PK_PROJECTVERSIONVIEWOPTION PRIMARY KEY (projectVersion_id, userName, optionName));

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.10_01', 'hp', 'dbF360_18.10.xml', NOW(), 561, '8:7670ffb1b1b56006b2074dd36a861fd1', 'createTable tableName=projectversionviewoption', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.10.xml::f360_18.10_02::hp
CREATE INDEX usersessionstate_user_idx ON usersessionstate(userName);

CREATE INDEX usersessionstate_pv_user_idx ON usersessionstate(projectVersionId, userName);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.10_02', 'hp', 'dbF360_18.10.xml', NOW(), 563, '8:5b209f02f25f84553dfe953fbe649fae', 'createIndex indexName=usersessionstate_user_idx, tableName=usersessionstate; createIndex indexName=usersessionstate_pv_user_idx, tableName=usersessionstate', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.10.xml::f360_18.10_03::hp
ALTER TABLE agentcredential ADD `description` VARCHAR(255) NULL, ADD type VARCHAR(255) NULL;

DROP INDEX ac_username ON agentcredential;

CREATE INDEX ac_userplussessionid_idx ON agentcredential(userName, sessionId);

CREATE INDEX ac_terminaldate_idx ON agentcredential(terminalDate);

CREATE INDEX alert_name_idx ON alert(name);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.10_03', 'hp', 'dbF360_18.10.xml', NOW(), 565, '8:7fa2d09b0df010a7786eacc6c55d3301', 'addColumn tableName=agentcredential; dropIndex indexName=ac_username, tableName=agentcredential; createIndex indexName=ac_userplussessionid_idx, tableName=agentcredential; createIndex indexName=ac_terminaldate_idx, tableName=agentcredential; creat...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.10.xml::f360_18.10_04::hp
UPDATE jobqueue SET jobClassName = 'com.fortify.manager.BLL.jobs.AuditAssistantPredictJob' WHERE jobName like 'JOB_CROSSBOW_REQUEST_PREDICTIONS%'
                and jobClassName = 'com.fortify.manager.BLL.jobs.CrossbowPredictJob';

UPDATE jobqueue SET jobClassName = 'com.fortify.manager.BLL.jobs.AuditAssistantApplyPredictionsJob' WHERE jobName like 'JOB_CROSSBOW_APPLY_PREDICTIONS%'
                and jobClassName = 'com.fortify.manager.BLL.jobs.CrossbowApplyPredictionsJob';

UPDATE jobqueue SET jobClassName = 'com.fortify.manager.BLL.jobs.AuditAssistantTrainJob' WHERE jobName like 'JOB_CROSSBOW_TRAIN%'
                and jobClassName = 'com.fortify.manager.BLL.jobs.CrossbowTrainJob';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.10_04', 'hp', 'dbF360_18.10.xml', NOW(), 567, '8:08095e45404db17ca5dd8dc784647232', 'update tableName=jobqueue; update tableName=jobqueue; update tableName=jobqueue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.10.xml::f360_18.10_05::hp
UPDATE configproperty
            SET groupName='auditassistant',
                propertyName = REPLACE(propertyName, 'crossbow', 'auditassistant'),
                subGroupName = REPLACE(subGroupName, 'crossbow', 'auditassistant')
            WHERE groupName='crossbow';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.10_05', 'hp', 'dbF360_18.10.xml', NOW(), 569, '8:adef56307c28ef651fb9d4e6bfd857e6', 'sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.10.xml::f360_18.10_06::hp
CREATE TABLE attrlookup_mapping (master_attr_id INT NOT NULL, master_attr_lookupindex INT NOT NULL, dep_attr_id INT NOT NULL, dep_attr_lookupindex INT NOT NULL, CONSTRAINT pk_attrlookup_mapping PRIMARY KEY (master_attr_id, master_attr_lookupindex, dep_attr_id, dep_attr_lookupindex));

CREATE INDEX attrlookup_mapping_dep_idx ON attrlookup_mapping(dep_attr_id, dep_attr_lookupindex);

ALTER TABLE attrlookup_mapping ADD CONSTRAINT FK_master_attr_l_map_attr_id FOREIGN KEY (master_attr_id) REFERENCES attr (id);

ALTER TABLE attrlookup_mapping ADD CONSTRAINT FK_mast_attr_l_map_attrlookidx FOREIGN KEY (master_attr_id, master_attr_lookupindex) REFERENCES attrlookup (attr_id, lookupIndex);

ALTER TABLE attrlookup_mapping ADD CONSTRAINT FK_dep_attr_l_map_attr_id FOREIGN KEY (dep_attr_id) REFERENCES attr (id);

ALTER TABLE attrlookup_mapping ADD CONSTRAINT FK_dep_attr_l_map_attrlookidx FOREIGN KEY (dep_attr_id, dep_attr_lookupindex) REFERENCES attrlookup (attr_id, lookupIndex);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.10_06', 'hp', 'dbF360_18.10.xml', NOW(), 571, '8:3f4fe4c88f0a7adb66353baeab4dc565', 'createTable tableName=attrlookup_mapping; createIndex indexName=attrlookup_mapping_dep_idx, tableName=attrlookup_mapping; addForeignKeyConstraint baseTableName=attrlookup_mapping, constraintName=FK_master_attr_l_map_attr_id, referencedTableName=at...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.10.xml::f360_18.10_07::hp
--  valueChangeType field is added to mark auto applied values
ALTER TABLE auditvalue ADD valueChangeType VARCHAR(16) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.10_07', 'hp', 'dbF360_18.10.xml', NOW(), 573, '8:8702a11da3d42477641cd9404fd9b5c9', 'addColumn tableName=auditvalue', 'valueChangeType field is added to mark auto applied values', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.10.xml::f360_18.10_08::hp
ALTER TABLE projectversion ADD customTagValuesAutoApply VARCHAR(1) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.10_08', 'hp', 'dbF360_18.10.xml', NOW(), 575, '8:7d66dfb5e47c71095c2e3aece5afd049', 'addColumn tableName=projectversion', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.10.xml::f360_18.10_09_mxsql::hp
ALTER TABLE sourcefile DROP PRIMARY KEY;

ALTER TABLE sourcefile ADD id BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY;

CREATE INDEX SOURCEFILE_CHECKSUM_IDX ON sourcefile(checksum);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.10_09_mxsql', 'hp', 'dbF360_18.10.xml', NOW(), 577, '8:6a5bbfa03cf08e7ef3cd6fa6ce124367', 'dropPrimaryKey tableName=sourcefile; addColumn tableName=sourcefile; createIndex indexName=SOURCEFILE_CHECKSUM_IDX, tableName=sourcefile', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.10.xml::f360_18.10_10::hp
ALTER TABLE analysisblob ADD checksum VARCHAR(60) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.10_10', 'hp', 'dbF360_18.10.xml', NOW(), 579, '8:81cb1547de5fc411775a3092fc59faf9', 'addColumn tableName=analysisblob', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.10.xml::f360_18.10_11::hp
UPDATE bugfieldtemplategroup SET `description` = 'templates for ALM text fields' WHERE description='templates for HPE ALM text fields';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.10_11', 'hp', 'dbF360_18.10.xml', NOW(), 581, '8:462b95f668b9584212bef71129c1c70c', 'update tableName=bugfieldtemplategroup', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.10.xml::f360_18.10_12::hp
DELETE FROM issuecache WHERE NOT EXISTS (SELECT issue.id FROM issue WHERE issuecache.issue_id = issue.id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.10_12', 'hp', 'dbF360_18.10.xml', NOW(), 583, '8:096b3cd20631455f5778a282e4c34fae', 'sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.10.xml::f360_18.10_13::hp
--  remove bugfield templates of legacy jira4 and update templategroup description for supported jira.
DELETE FROM bugfieldtemplategroup WHERE bugTrackerPluginId = 'com.fortify.sample.defecttracking.jira.Jira4BugTrackerPlugin';

UPDATE bugfieldtemplategroup SET `description` = 'templates for JIRA text fields' WHERE description='templates for JIRA 7 (plugin using REST api) text fields';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.10_13', 'hp', 'dbF360_18.10.xml', NOW(), 585, '8:f380c472b0ff2b0d4b90554d4aa03546', 'delete tableName=bugfieldtemplategroup; update tableName=bugfieldtemplategroup', 'remove bugfield templates of legacy jira4 and update templategroup description for supported jira.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.20.xml::f360_18.20_1::fortify
--  Migrate scan_issue_ca table: replace scan_issue_id column by issue instance ID.
CREATE TABLE scan_issue_ca_temp (projectVersion_id BIGINT NOT NULL, scan_id BIGINT NOT NULL, issueInstanceId VARCHAR(80) NOT NULL, engineType VARCHAR(20) NOT NULL, metadataPluginId VARCHAR(80) NOT NULL, dataVersion INT NOT NULL, integerValue01 INT NULL, integerValue02 INT NULL, integerValue03 INT NULL, decimalValue01 DECIMAL(18, 9) NULL, decimalValue02 DECIMAL(18, 9) NULL, decimalValue03 DECIMAL(18, 9) NULL, decimalValue04 DECIMAL(18, 9) NULL, decimalValue05 DECIMAL(18, 9) NULL, dateValue01 date NULL, dateValue02 date NULL, dateValue03 date NULL, dateValue04 date NULL, dateValue05 date NULL, textValue01 VARCHAR(800) NULL, textValue02 VARCHAR(800) NULL, textValue03 VARCHAR(800) NULL, textValue04 VARCHAR(800) NULL, textValue05 VARCHAR(800) NULL, textValue06 VARCHAR(800) NULL, textValue07 VARCHAR(800) NULL, textValue08 VARCHAR(800) NULL, textValue09 VARCHAR(800) NULL, textValue10 VARCHAR(800) NULL, textValue11 VARCHAR(800) NULL, textValue12 VARCHAR(800) NULL, textValue13 VARCHAR(800) NULL, textValue14 VARCHAR(800) NULL, textValue15 VARCHAR(800) NULL, textValue16 VARCHAR(800) NULL, clobValue01 MEDIUMTEXT NULL, clobValue02 MEDIUMTEXT NULL, clobValue03 MEDIUMTEXT NULL, clobValue04 MEDIUMTEXT NULL, clobValue05 MEDIUMTEXT NULL, clobValue06 MEDIUMTEXT NULL);

INSERT INTO scan_issue_ca_temp (projectVersion_id, scan_id, issueInstanceId, engineType, metadataPluginId, dataVersion,
                                            integerValue01, integerValue02, integerValue03,
                                            decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
                                            dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
                                            textValue01, textValue02, textValue03, textValue04,
                                            textValue05, textValue06, textValue07, textValue08,
                                            textValue09, textValue10, textValue11, textValue12,
                                            clobValue01, clobValue02
                                            )
            SELECT sic.projectVersion_id,
                   sic.scan_id,
                   si.issueInstanceId,
                   si.engineType,
                   sic.metadataPluginId,
                   sic.dataVersion,
                   integerValue01, integerValue02, integerValue03,
                   decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
                   dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
                   textValue01, textValue02, textValue03, textValue04,
                   textValue05, textValue06, textValue07, textValue08,
                   textValue09, textValue10, textValue11, textValue12,
                   clobValue01, clobValue02
            FROM scan_issue_ca sic, scan_issue si
            WHERE sic.scan_issue_id = si.id;

DROP TABLE scan_issue_ca;

ALTER TABLE scan_issue_ca_temp RENAME scan_issue_ca;

ALTER TABLE scan_issue_ca ADD PRIMARY KEY (scan_id, issueInstanceId);

CREATE INDEX SCAN_ISSUE_CA_PV_SCAN_ID_IDX ON scan_issue_ca(projectVersion_id, scan_id, issueInstanceId);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.20_1', 'fortify', 'dbF360_18.20.xml', NOW(), 587, '8:28326c57b61a54f80a39913a62298c4f', 'createTable tableName=scan_issue_ca_temp; sql; dropTable tableName=scan_issue_ca; renameTable newTableName=scan_issue_ca, oldTableName=scan_issue_ca_temp; addPrimaryKey constraintName=PK_SCAN_ISSUE_CA, tableName=scan_issue_ca; createIndex indexNam...', 'Migrate scan_issue_ca table: replace scan_issue_id column by issue instance ID.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.20.xml::f360_18.20_2::fortify
ALTER TABLE projectversion ADD autoPredict VARCHAR(1) DEFAULT 'N' NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.20_2', 'fortify', 'dbF360_18.20.xml', NOW(), 589, '8:f26463951aefa07d085ba4a6fc7c7d8a', 'addColumn tableName=projectversion', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.20.xml::f360_18.20_3::fortify
ALTER TABLE projectversion ADD predictionPolicy VARCHAR(1024) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.20_3', 'fortify', 'dbF360_18.20.xml', NOW(), 591, '8:3495bff011b7f10722c1adef35453ad8', 'addColumn tableName=projectversion', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_18.20.xml::f360_18.20_4::fortify
ALTER TABLE catpackexternallist MODIFY `description` VARCHAR(4000);

ALTER TABLE catpackexternalcategory MODIFY `description` VARCHAR(4000);

ALTER TABLE rulepack MODIFY `description` VARCHAR(4000);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_18.20_4', 'fortify', 'dbF360_18.20.xml', NOW(), 593, '8:07d2f5bcf3e196f8320ac51ad5dbfc04', 'modifyDataType columnName=description, tableName=catpackexternallist; modifyDataType columnName=description, tableName=catpackexternalcategory; modifyDataType columnName=description, tableName=rulepack', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.1.xml::f360_19.1_1::fortify
--  Drop stored procedure that is not used anywhere
DROP PROCEDURE migrateScanIssueIds;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.1_1', 'fortify', 'dbF360_19.1.xml', NOW(), 595, '8:5b5fb737025a2cee6fa9f87a9e832388', 'sql', 'Drop stored procedure that is not used anywhere', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.1.xml::f360_19.1_2::fortify
--  Make enabled/disabled [Trust cert provided by smtp server] checkbox dynamically dependent on [Enable SSL/TSL encryption] checkbox
UPDATE configproperty SET groupSwitch = 'Y', subGroupName = 'email.server.ssl' WHERE propertyName = 'email.server.ssl.enabled';

UPDATE configproperty SET subGroupName = 'email.server.ssl' WHERE propertyName = 'email.server.ssl.trustHostCertificate';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.1_2', 'fortify', 'dbF360_19.1.xml', NOW(), 597, '8:7c61714bb28521ceb3f210c6451c39f4', 'update tableName=configproperty; update tableName=configproperty', 'Make enabled/disabled [Trust cert provided by smtp server] checkbox dynamically dependent on [Enable SSL/TSL encryption] checkbox', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.1.xml::f360_19.1_3::fortify
--  Change the obsolete 3-spaces default AA prediction policy from 3-spaces (set in previous versions) to null
UPDATE configproperty SET propertyValue = NULL WHERE propertyName='auditassistant.prediction.policy' and propertyValue='   ';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.1_3', 'fortify', 'dbF360_19.1.xml', NOW(), 599, '8:f34aca1c62836937adf5d79f6e00cec7', 'update tableName=configproperty', 'Change the obsolete 3-spaces default AA prediction policy from 3-spaces (set in previous versions) to null', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.1.xml::f360_19.1_4::fortify
UPDATE fortifyuser SET secPass = concat('{',concat(salt,concat('}',secPass))) WHERE salt IS NOT NULL AND secPass IS NOT NULL;

ALTER TABLE fortifyuser DROP COLUMN salt;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.1_4', 'fortify', 'dbF360_19.1.xml', NOW(), 601, '8:abfb8c588fcd60f1ebe173d458a013a4', 'update tableName=fortifyuser; dropColumn columnName=salt, tableName=fortifyuser', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.1.xml::f360_19.1_5::fortify
ALTER TABLE rule_t ADD customHeader VARCHAR(255) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.1_5', 'fortify', 'dbF360_19.1.xml', NOW(), 603, '8:98c11fa2cf750610e81f53d5de7088f7', 'addColumn tableName=rule_t', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.1.xml::f360_19.1_6::fortify
DELETE FROM jobqueue WHERE jobClassName = 'com.fortify.manager.BLL.jobs.ActivityAlertsJob';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.1_6', 'fortify', 'dbF360_19.1.xml', NOW(), 605, '8:1488032548d441ecba1aac0453401d06', 'delete tableName=jobqueue', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.2.xml::f360_19.2_1::fortify
UPDATE bugfieldtemplategroup SET `description` = 'Templates for Bugzilla text fields' WHERE description='templates for Bugzilla text fields';

UPDATE bugfieldtemplategroup SET `description` = 'Templates for Jira text fields' WHERE description='templates for JIRA text fields';

UPDATE bugfieldtemplategroup SET `description` = 'Templates for ALM text fields' WHERE description='templates for ALM text fields';

UPDATE bugfieldtemplategroup SET `description` = 'Templates for Azure DevOps / TFS text fields' WHERE description='templates for TFS/Visual Studio Online text fields';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.2_1', 'fortify', 'dbF360_19.2.xml', NOW(), 607, '8:6b45b0e60082f87a41390c592b4fd919', 'update tableName=bugfieldtemplategroup; update tableName=bugfieldtemplategroup; update tableName=bugfieldtemplategroup; update tableName=bugfieldtemplategroup', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.2.xml::f360_19.2_2::fortify
--  Drop Runtime-related tables and related FK constraints.
DROP TABLE hostinfo;

DROP TABLE hostlogmessage;

DROP TABLE consoleeventhandler;

ALTER TABLE controller DROP FOREIGN KEY RefKeyKeeperController;

DROP TABLE controllerkeykeeper;

ALTER TABLE host DROP FOREIGN KEY RefControllerHost;

DROP TABLE controller;

ALTER TABLE runtimeevent DROP FOREIGN KEY RefHostRE;

ALTER TABLE applicationassignmentrule_host DROP FOREIGN KEY RefHostAppAssignRuleHost;

DROP TABLE host;

DROP TABLE federation;

DROP TABLE runtimealert;

DROP TABLE runtimeconfig_rulepack;

DROP TABLE runtimeeventarchive;

DROP TABLE runtimeeventattr;

DROP TABLE runtimenamedattr;

DROP TABLE runtimenamedattrset;

DROP TABLE runtimesetting;

DROP TABLE runtimeevent;

DROP TABLE runtimeconfiguration;

ALTER TABLE applicationassignmentrule DROP FOREIGN KEY RefRuntimeAppAssignRule;

DROP TABLE applicationassignmentrule_host;

DROP TABLE idgenerator;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.2_2', 'fortify', 'dbF360_19.2.xml', NOW(), 609, '8:2b4ccce4688bb7783d9fe6eff1fbc0c7', 'dropTable tableName=hostinfo; dropTable tableName=hostlogmessage; dropTable tableName=consoleeventhandler; dropForeignKeyConstraint baseTableName=controller, constraintName=RefKeyKeeperController; dropTable tableName=controllerkeykeeper; dropForei...', 'Drop Runtime-related tables and related FK constraints.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.2.xml::f360_19.2_3::fortify
--  This constraint is not needed since projectstateactivity is not in use anymore
ALTER TABLE projectstateactivity DROP FOREIGN KEY RefMeasProjStatAct;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.2_3', 'fortify', 'dbF360_19.2.xml', NOW(), 611, '8:a4b373c40947c92287d7a91d55467307', 'dropForeignKeyConstraint baseTableName=projectstateactivity, constraintName=RefMeasProjStatAct', 'This constraint is not needed since projectstateactivity is not in use anymore', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.2.xml::f360_19.2_4::fortify
--  Delete RUNTIME-related podType entries from DB since those podType enums have been deleted from code
DELETE FROM pod WHERE podType = 'RUNTIME_HOST_STATUS' OR podType = 'RUNTIME_EVENTS';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.2_4', 'fortify', 'dbF360_19.2.xml', NOW(), 613, '8:e6bb12d7c4351accfa5491c0b795c8f1', 'delete tableName=pod', 'Delete RUNTIME-related podType entries from DB since those podType enums have been deleted from code', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.2.xml::f360_19.2_5::fortify
--  Changes for Defect 259023 - Runtime removal : Handle removal of Runtime elements from database during migration to 19.2.
DELETE FROM metavalueselection WHERE metaValue_id in (select id from metavalue where metaDef_id in (select id from metadef where appEntityType = 'RUNTIME_APP'));

DELETE FROM metavalue WHERE metaDef_id in (select id from metadef where appEntityType = 'RUNTIME_APP');

DELETE FROM metaoption_t WHERE metaOption_id in (select id from metaoption where metaDef_id in (select id from metadef where appEntityType = 'RUNTIME_APP'));

DELETE FROM metaoption WHERE metaDef_id in (select id from metadef where appEntityType = 'RUNTIME_APP');

DELETE FROM metadef_t WHERE metaDef_id in (select id from metadef where appEntityType = 'RUNTIME_APP');

DELETE FROM metadef WHERE appEntityType = 'RUNTIME_APP';

update metadef set appEntityType = 'PROJECT_VERSION' where appEntityType = 'ALL';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.2_5', 'fortify', 'dbF360_19.2.xml', NOW(), 615, '8:3b529ef176947d89da11469f859cd461', 'delete tableName=metavalueselection; delete tableName=metavalue; delete tableName=metaoption_t; delete tableName=metaoption; delete tableName=metadef_t; delete tableName=metadef; sql', 'Changes for Defect 259023 - Runtime removal : Handle removal of Runtime elements from database during migration to 19.2.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.2.xml::f360_19.2_6::fortify
--  Delete Runtime rulepacks and associated file blobs
DELETE FROM datablob WHERE id in (select fileBlob_id from documentinfo where id in (select documentInfo_id from rulepack where rulepackType = 'RTA'));

DELETE FROM documentinfo WHERE id in (select documentInfo_id from rulepack where rulepackType = 'RTA');

DELETE FROM rulepack WHERE rulepackType = 'RTA';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.2_6', 'fortify', 'dbF360_19.2.xml', NOW(), 617, '8:d786a86f82fd5617cc3f9c3ddfa528ba', 'delete tableName=datablob; delete tableName=documentinfo; delete tableName=rulepack', 'Delete Runtime rulepacks and associated file blobs', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.2.xml::f360_19.2_7::fortify
--  Fix for Defect 266171 - Jobs 500 Error. Delete "runtime" jobs from jobqueue table.
DELETE FROM jobqueue WHERE jobClassName like '%runtime%';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.2_7', 'fortify', 'dbF360_19.2.xml', NOW(), 619, '8:681eade2bd57d9cfd61a05922f198257', 'delete tableName=jobqueue', 'Fix for Defect 266171 - Jobs 500 Error. Delete "runtime" jobs from jobqueue table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_19.2.xml::f360_19.2_8::fortify
--  Drop foreign key from snapshot to projectversion table as a prevention against deadlocks.
ALTER TABLE snapshot DROP FOREIGN KEY RefPVSnapshot;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_19.2_8', 'fortify', 'dbF360_19.2.xml', NOW(), 621, '8:97b38825878d93372bf26a11008c1778', 'dropForeignKeyConstraint baseTableName=snapshot, constraintName=RefPVSnapshot', 'Drop foreign key from snapshot to projectversion table as a prevention against deadlocks.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_20.1.xml::f360_20.1_2::fortify
--  Migrate to tagged password hashes
UPDATE fortifyuser SET password = CONCAT('{sha}', secPass) WHERE secPass IS NOT NULL;

ALTER TABLE fortifyuser DROP COLUMN secPass;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_20.1_2', 'fortify', 'dbF360_20.1.xml', NOW(), 623, '8:b7eef1666346fba5a5e6b6f28c6529f1', 'update tableName=fortifyuser; dropColumn columnName=secPass, tableName=fortifyuser', 'Migrate to tagged password hashes', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_20.1.xml::f360_20.1_3::fortify
--  Drop no longer used manage event logs permissions
DELETE FROM permissiongroup_dependants WHERE permissionGroup_id in (select id from permissiongroup where guid='eventlog_manage');

DELETE FROM permissiongroup WHERE guid='eventlog_manage';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_20.1_3', 'fortify', 'dbF360_20.1.xml', NOW(), 625, '8:d6e0c228e56ab132c3cb4eaf9fe52e2d', 'delete tableName=permissiongroup_dependants; delete tableName=permissiongroup', 'Drop no longer used manage event logs permissions', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_20.2.xml::f360_20.2_1::fortify
ALTER TABLE projectstateai DROP FOREIGN KEY RefMeasProjStatAI;

ALTER TABLE projectstateai ADD CONSTRAINT RefMeasProjStatAI FOREIGN KEY (measurement_id) REFERENCES measurement (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_20.2_1', 'fortify', 'dbF360_20.2.xml', NOW(), 627, '8:1f5bbe0567e1831b57a50275cf1e5ece', 'dropForeignKeyConstraint baseTableName=projectstateai, constraintName=RefMeasProjStatAI; addForeignKeyConstraint baseTableName=projectstateai, constraintName=RefMeasProjStatAI, referencedTableName=measurement', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_20.2.xml::f360_20.2_2::fortify
--  Delete dataBlobs, documentInfo entries, saved reports, report parameters and report definitions
--              for SSA reports, in that order.
DELETE FROM datablob WHERE id IN (
                    SELECT fileBlob_id FROM documentinfo di
                    JOIN savedreport sr on sr.reportOutputDoc_id = di.id
                    JOIN reportdefinition rd ON rd.id = sr.reportDefinition_id
                    WHERE rd.reportType like 'SSA%');

DELETE FROM documentinfo WHERE id IN (
                    SELECT reportOutputDoc_id FROM savedreport sr
                    JOIN reportdefinition rd ON rd.id = sr.reportDefinition_id
                    WHERE rd.reportType like 'SSA%');

DELETE FROM savedreport WHERE reportDefinition_id IN (
                    SELECT id FROM reportdefinition rd
                    WHERE rd.reportType like 'SSA%');

DELETE FROM reportparameter WHERE reportDefinition_id IN (
                    SELECT id FROM reportdefinition rd
                    WHERE rd.reportType like 'SSA%');

DELETE FROM reportdefinition WHERE reportType LIKE 'SSA%';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_20.2_2', 'fortify', 'dbF360_20.2.xml', NOW(), 629, '8:19498db78f1fdba956d651fa0300840d', 'delete tableName=datablob; delete tableName=documentinfo; delete tableName=savedreport; delete tableName=reportparameter; delete tableName=reportdefinition', 'Delete dataBlobs, documentInfo entries, saved reports, report parameters and report definitions
            for SSA reports, in that order.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_20.2.xml::f360_20.2_3::fortify
UPDATE bugfieldtemplategroup SET `description` = 'Templates for Azure DevOps text fields' WHERE description='Templates for Azure DevOps / TFS text fields';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_20.2_3', 'fortify', 'dbF360_20.2.xml', NOW(), 631, '8:0a115262b31909b152edf8bb9126b8ca', 'update tableName=bugfieldtemplategroup', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_20.2.xml::f360_20.2_4::fortify
CREATE TABLE webhook (id INT AUTO_INCREMENT NOT NULL, url VARCHAR(1024) NOT NULL, useSscProxy VARCHAR(1) NOT NULL, allowInsecureTLS VARCHAR(1) NOT NULL, contentType VARCHAR(50) NOT NULL, active VARCHAR(1) NOT NULL, monitorAllEvents VARCHAR(1) NOT NULL, monitorAllAppVersions VARCHAR(1) NOT NULL, secretValue VARCHAR(255) NULL, `description` VARCHAR(2000) NULL, createdBy VARCHAR(255) NOT NULL, creationDate datetime NOT NULL, objectVersion INT NULL, CONSTRAINT PK_WEBHOOK PRIMARY KEY (id));

CREATE TABLE webhook_event (webhook_id INT NOT NULL, event VARCHAR(80) NOT NULL);

ALTER TABLE webhook_event ADD PRIMARY KEY (webhook_id, event);

ALTER TABLE webhook_event ADD CONSTRAINT fk_webhook_webhook_event FOREIGN KEY (webhook_id) REFERENCES webhook (id) ON DELETE CASCADE;

CREATE TABLE webhook_pv (webhook_id INT NOT NULL, projectVersion_id INT NOT NULL);

ALTER TABLE webhook_pv ADD PRIMARY KEY (webhook_id, projectVersion_id);

ALTER TABLE webhook_pv ADD CONSTRAINT fk_webhook_pv_webhook FOREIGN KEY (webhook_id) REFERENCES webhook (id) ON DELETE CASCADE;

CREATE TABLE webhookhistory (id INT AUTO_INCREMENT NOT NULL, webhook_id INT NOT NULL, createdAt datetime NOT NULL, contentType VARCHAR(50) NOT NULL, requestHeaders MEDIUMBLOB NULL, requestPayload MEDIUMBLOB NULL, responseHeaders MEDIUMBLOB NULL, responseBody MEDIUMBLOB NULL, responseCode INT NULL, failureReason VARCHAR(255) NULL, status VARCHAR(50) NOT NULL, CONSTRAINT PK_WEBHOOKHISTORY PRIMARY KEY (id));

ALTER TABLE webhookhistory ADD CONSTRAINT fk_webhook_webhookhistory FOREIGN KEY (webhook_id) REFERENCES webhook (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_20.2_4', 'fortify', 'dbF360_20.2.xml', NOW(), 633, '8:e4b14b8064554a67e671242c9c998f70', 'createTable tableName=webhook; createTable tableName=webhook_event; addPrimaryKey constraintName=PK_webhook_event, tableName=webhook_event; addForeignKeyConstraint baseTableName=webhook_event, constraintName=fk_webhook_webhook_event, referencedTab...', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_20.2.xml::f360_20.2_5::fortify
--  Flag to hide obsolete mappings in externalmetadata file
ALTER TABLE catpackexternallist ADD obsolete VARCHAR(1) DEFAULT 'N' NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_20.2_5', 'fortify', 'dbF360_20.2.xml', NOW(), 635, '8:b6902380b2c6cde0b5298c3845733338', 'addColumn tableName=catpackexternallist', 'Flag to hide obsolete mappings in externalmetadata file', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_20.2.xml::f360_20.2_6::fortify
--  Replace SAML Entity ID and Alias default values - only in case where SAML config has not been used yet.
UPDATE configproperty SET propertyValue = 'https://ssc.fortify.example.com/' WHERE propertyName = 'saml.sp.entityId'
                  AND objectVersion IN (1, 2)
                  AND EXISTS(SELECT one
                      FROM (
                             SELECT 1 one
                             FROM configproperty c2
                             WHERE c2.propertyName = 'saml.enabled'
                               AND c2.objectVersion IN (1, 2)
                           ) c3);

UPDATE configproperty SET propertyValue = 'fortify_ssc' WHERE propertyName = 'saml.sp.alias'
                  AND objectVersion IN (1, 2)
                  AND EXISTS(SELECT one
                      FROM (
                             SELECT 1 one
                             FROM configproperty c2
                             WHERE c2.propertyName = 'saml.enabled'
                               AND c2.objectVersion IN (1, 2)
                           ) c3);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_20.2_6', 'fortify', 'dbF360_20.2.xml', NOW(), 637, '8:3382648605c8d4d7d6f10326934a68b4', 'update tableName=configproperty; update tableName=configproperty', 'Replace SAML Entity ID and Alias default values - only in case where SAML config has not been used yet.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_common::fortify
--  Enhance to millisecond precision.
--              Change DATETIME columns in smaller or less important tables to DATETIME(3) in one changelist.
DROP INDEX ac_terminaldate_idx ON agentcredential;

ALTER TABLE agentcredential MODIFY creationDate datetime(3);

ALTER TABLE agentcredential MODIFY terminalDate datetime(3);

CREATE INDEX ac_terminaldate_idx ON agentcredential(terminalDate);

ALTER TABLE alert MODIFY creationDate datetime(3);

ALTER TABLE alert MODIFY endDate datetime(3);

ALTER TABLE alert MODIFY startDate datetime(3);

ALTER TABLE alerthistory MODIFY alertStartDate datetime(3);

ALTER TABLE alerthistory MODIFY triggeredDate datetime(3);

ALTER TABLE auditassistanttrainingstatus MODIFY lastTrainingTime datetime(3);

ALTER TABLE auditattachment MODIFY updateTime datetime(3) NOT NULL;

ALTER TABLE dataexport MODIFY exportDate datetime(3) not null;

ALTER TABLE fortifyuser MODIFY dateFrozen datetime(3);

ALTER TABLE fortifyuser MODIFY lastPasswordChange datetime(3);

ALTER TABLE iidmigration MODIFY processingDate datetime(3);

ALTER TABLE ldapserver MODIFY updateTime datetime(3) NOT NULL;

ALTER TABLE savedreport MODIFY generationDate datetime(3) NOT NULL;

ALTER TABLE seedhistory MODIFY seedDate datetime(3);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_common', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 639, '8:d0bdbe6ee1fa7f49ecc82cbd79889706', 'dropIndex indexName=ac_terminaldate_idx, tableName=agentcredential; sql; createIndex indexName=ac_terminaldate_idx, tableName=agentcredential; sql; sql; sql; sql; sql; sql; sql; sql; sql; sql', 'Enhance to millisecond precision.
            Change DATETIME columns in smaller or less important tables to DATETIME(3) in one changelist.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_eventlogentry::fortify
--  Enhance to millisecond precision.
--              Change DATETIME to DATETIME(3) columns in eventlogentry table.
DROP INDEX EVENTLOGENTRY_EVENTDATE_IDX ON eventlogentry;

ALTER TABLE eventlogentry MODIFY eventDate datetime(3);

CREATE INDEX EVENTLOGENTRY_EVENTDATE_IDX ON eventlogentry(eventDate);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_eventlogentry', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 641, '8:f10437871f7c1258b291608044193d02', 'dropIndex indexName=EVENTLOGENTRY_EVENTDATE_IDX, tableName=eventlogentry; sql; createIndex indexName=EVENTLOGENTRY_EVENTDATE_IDX, tableName=eventlogentry', 'Enhance to millisecond precision.
            Change DATETIME to DATETIME(3) columns in eventlogentry table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_jobqueue::fortify
--  Enhance to millisecond precision.
--              Change DATETIME to DATETIME(3) columns in jobqueue table.
ALTER TABLE jobqueue MODIFY finishTime datetime(3);

ALTER TABLE jobqueue MODIFY startTime datetime(3);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_jobqueue', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 643, '8:8008aa0477c621f859042378eefa2ab5', 'sql', 'Enhance to millisecond precision.
            Change DATETIME to DATETIME(3) columns in jobqueue table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_cloudjob::fortify
--  Enhance to millisecond precision.
--              Change DATETIME to DATETIME(3) columns in cloudjob table.
DROP INDEX CLOUDJOB_EXPIRYTIME_IDX ON cloudjob;

ALTER TABLE cloudjob MODIFY jobExpiryTime datetime(3);

ALTER TABLE cloudjob MODIFY jobFinishedTime datetime(3);

ALTER TABLE cloudjob MODIFY jobQueuedTime datetime(3);

ALTER TABLE cloudjob MODIFY jobStartedTime datetime(3);

CREATE INDEX CLOUDJOB_EXPIRYTIME_IDX ON cloudjob(jobExpiryTime);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_cloudjob', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 645, '8:27db0607c1a49c2d3a99230763b400a0', 'dropIndex indexName=CLOUDJOB_EXPIRYTIME_IDX, tableName=cloudjob; sql; createIndex indexName=CLOUDJOB_EXPIRYTIME_IDX, tableName=cloudjob', 'Enhance to millisecond precision.
            Change DATETIME to DATETIME(3) columns in cloudjob table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_cloudworker::fortify
--  Enhance to millisecond precision.
--              Change DATETIME to DATETIME(3) columns in cloudworker table.
DROP INDEX WORKER_EXPIRYTIME_IDX ON cloudworker;

ALTER TABLE cloudworker MODIFY lastSeen datetime(3);

ALTER TABLE cloudworker MODIFY workerExpiryTime datetime(3);

ALTER TABLE cloudworker MODIFY workerStartTime datetime(3);

CREATE INDEX WORKER_EXPIRYTIME_IDX ON cloudworker(workerExpiryTime);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_cloudworker', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 647, '8:158b312d0f051d339cdcfa9bbed2576b', 'dropIndex indexName=WORKER_EXPIRYTIME_IDX, tableName=cloudworker; sql; createIndex indexName=WORKER_EXPIRYTIME_IDX, tableName=cloudworker', 'Enhance to millisecond precision.
            Change DATETIME to DATETIME(3) columns in cloudworker table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_measurementhistory::fortify
--  Enhance to millisecond precision.
--              Change DATETIME to DATETIME(3) columns in measurementhistory table
ALTER TABLE measurementhistory MODIFY creationTime datetime(3);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_measurementhistory', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 649, '8:28fba54213ee9e37e6fadda76ba25021', 'sql', 'Enhance to millisecond precision.
            Change DATETIME to DATETIME(3) columns in measurementhistory table', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_project::fortify
--  Enhance to millisecond precision.
--              Change DATETIME to DATETIME(3) columns in project table.
ALTER TABLE project MODIFY creationDate datetime(3);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_project', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 651, '8:a49e12f4cdf71bd1d8bcc384df29e9fb', 'sql', 'Enhance to millisecond precision.
            Change DATETIME to DATETIME(3) columns in project table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_projectversion::fortify
--  Enhance to millisecond precision.
--              Change DATETIME to DATETIME(3) columns in projectversion table
ALTER TABLE projectversion MODIFY creationDate datetime;

ALTER TABLE projectversion MODIFY creationDate datetime(3);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_projectversion', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 653, '8:9a7a7f607f7d780859566a20e1883ec4', 'modifyDataType columnName=creationDate, tableName=projectversion; sql', 'Enhance to millisecond precision.
            Change DATETIME to DATETIME(3) columns in projectversion table', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_artifact::fortify
--  Enhance to millisecond precision.
--              Change DATETIME to DATETIME(3) columns in artifact table.
ALTER TABLE artifact MODIFY approvalDate datetime(3);

ALTER TABLE artifact MODIFY uploadDate datetime(3);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_artifact', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 655, '8:8f3eb6a39c3a7e8ee364278b0f4c2a8d', 'sql', 'Enhance to millisecond precision.
            Change DATETIME to DATETIME(3) columns in artifact table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_documentinfo::fortify
--  Enhance to millisecond precision.
--              Change DATETIME to DATETIME(3) columns in documentinfo table.
ALTER TABLE documentinfo MODIFY uploadDate datetime(3);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_documentinfo', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 657, '8:df1937c0111d887e16005dc21b31be72', 'sql', 'Enhance to millisecond precision.
            Change DATETIME to DATETIME(3) columns in documentinfo table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_snapshot::fortify
--  Enhance to millisecond precision.
--              Change DATETIME to DATETIME(3) columns in snapshot table.
DROP INDEX ss_proj_date ON snapshot;

ALTER TABLE snapshot MODIFY startDate datetime(3);

ALTER TABLE snapshot MODIFY finishDate datetime(3);

CREATE INDEX ss_proj_date ON snapshot(projectVersion_id, startDate);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_snapshot', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 659, '8:9d487ba01b0ef8bfc4e39029ceb84324', 'dropIndex indexName=ss_proj_date, tableName=snapshot; sql; createIndex indexName=ss_proj_date, tableName=snapshot', 'Enhance to millisecond precision.
            Change DATETIME to DATETIME(3) columns in snapshot table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_scan::fortify
--  Enhance to millisecond precision.
--              Change DATETIME to DATETIME(3) columns in scan table.
ALTER TABLE scan MODIFY updateDate datetime(3);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_scan', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 661, '8:a12f12a9c24f215f805e1c5e8b6da3a6', 'sql', 'Enhance to millisecond precision.
            Change DATETIME to DATETIME(3) columns in scan table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_dynamicscan::fortify
--  Enhance to millisecond precision.
--              Change DATETIME to DATETIME(3) columns in dynamicscan table.
ALTER TABLE dynamicscan MODIFY lastUpdateDate datetime(3);

ALTER TABLE dynamicscan MODIFY requestedDate datetime(3);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_dynamicscan', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 663, '8:e11eefb8806984276f983b0e04e1eba6', 'sql', 'Enhance to millisecond precision.
            Change DATETIME to DATETIME(3) columns in dynamicscan table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_20.2_datetime.xml::f360Mysql_20.2_datetime_variablehistory::fortify
--  Enhance to millisecond precision.
--              Change DATETIME to DATETIME(3) columns in variablehistory table.
ALTER TABLE variablehistory MODIFY creationTime datetime(3);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_20.2_datetime_variablehistory', 'fortify', 'dbF360Mysql_20.2_datetime.xml', NOW(), 665, '8:aab0abd0f232bc07cdd2727dd70b1e73', 'sql', 'Enhance to millisecond precision.
            Change DATETIME to DATETIME(3) columns in variablehistory table.', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1_1::fortify
--  Clear checkSSLTrust and checkSSLHostname for ldapservers not using ldaps protocol to maintain current behaviour due to implementation of StartTLS connection
UPDATE ldapserver SET checkSslHostname = 'N', checkSslTrust = 'N' WHERE url LIKE 'ldap:%';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1_1', 'fortify', 'dbF360_21.1.xml', NOW(), 667, '8:5d7f7fcb94227deec6a07fe9a8923711', 'update tableName=ldapserver', 'Clear checkSSLTrust and checkSSLHostname for ldapservers not using ldaps protocol to maintain current behaviour due to implementation of StartTLS connection', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1_2::fortify
--  Remove unused batch bug submission tables
DROP TABLE bbstrategyissuegrouping;

DROP TABLE bbstrategyparametervalue;

DROP TABLE bbstrategy;

DROP TABLE bbstemplateissuegrouping;

DROP TABLE bbstemplate;

DROP TABLE batchbugsubmission;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1_2', 'fortify', 'dbF360_21.1.xml', NOW(), 669, '8:f24cc06c4302222d10f05d5f26afa720', 'dropTable tableName=bbstrategyissuegrouping; dropTable tableName=bbstrategyparametervalue; dropTable tableName=bbstrategy; dropTable tableName=bbstemplateissuegrouping; dropTable tableName=bbstemplate; dropTable tableName=batchbugsubmission', 'Remove unused batch bug submission tables', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1_3::fortify
--  Remove unused pod and page preferences tables
DROP TABLE pref_page;

DROP TABLE pref_pod;

DROP TABLE pod;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1_3', 'fortify', 'dbF360_21.1.xml', NOW(), 671, '8:4f009d024f77be16da09a2291df6d710', 'dropTable tableName=pref_page; dropTable tableName=pref_pod; dropTable tableName=pod', 'Remove unused pod and page preferences tables', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1_4::fortify
--  Remove unused governance tables
DROP TABLE activitycomment;

DROP TABLE activitysignoff;

DROP TABLE documentdefinstance;

DROP TABLE documentai;

DROP TABLE documentartifact_def;

DROP TABLE measurementinstance;

DROP TABLE variableinstance;

DROP TABLE projectstateai;

DROP TABLE taskcomment;

DROP TABLE taskinstance;

DROP TABLE timelapse_event;

DROP TABLE timelapseai;

DROP TABLE activityinstance;

DROP TABLE requirementtemplatecomment;

DROP TABLE requirementtemplatesignoff;

DROP TABLE requirementtemplateinstance;

DROP TABLE requirementcomment;

DROP TABLE requirementsignoff;

DROP TABLE requirementinstance;

DROP TABLE sdlhistory;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1_4', 'fortify', 'dbF360_21.1.xml', NOW(), 673, '8:b40f6d660241d8702b6a73c4a550685f', 'dropTable tableName=activitycomment; dropTable tableName=activitysignoff; dropTable tableName=documentdefinstance; dropTable tableName=documentai; dropTable tableName=documentartifact_def; dropTable tableName=measurementinstance; dropTable tableNa...', 'Remove unused governance tables', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1_5::fortify
--  Remove unused governance document artifacts and associated file blobs
DELETE FROM datablob WHERE EXISTS (SELECT 1 FROM documentartifact da
                 INNER JOIN documentinfo di ON da.documentInfo_id = di.id
                 WHERE di.fileBlob_id = datablob.id);

DELETE FROM documentinfo WHERE EXISTS (SELECT 1 FROM documentartifact da WHERE documentinfo.id = da.documentInfo_id);

DROP TABLE documentartifact;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1_5', 'fortify', 'dbF360_21.1.xml', NOW(), 675, '8:76258ca733eb38711be5ad4b26bf7caa', 'delete tableName=datablob; delete tableName=documentinfo; dropTable tableName=documentartifact', 'Remove unused governance document artifacts and associated file blobs', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1_6::fortify
--  Remove unused governance saved evidence and associated file blobs
DELETE FROM datablob WHERE EXISTS(SELECT 1 FROM savedevidence se WHERE datablob.id = se.evidenceBlob_id)
                AND
                NOT EXISTS(SELECT 1 FROM documentinfo di WHERE datablob.id = di.fileBlob_id);

DROP TABLE savedevidence;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1_6', 'fortify', 'dbF360_21.1.xml', NOW(), 677, '8:6d8d293ce86d6c93686b0d92d1218384', 'delete tableName=datablob; dropTable tableName=savedevidence', 'Remove unused governance saved evidence and associated file blobs', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1_7::fortify
--  Remove unused governance alerts
DELETE FROM alert WHERE EXISTS (select 1 from alerttrigger atr where (alert.id = atr.alert_id)) AND
                NOT EXISTS (select 1 from alerttrigger atr where (alert.id = atr.alert_id and atr.triggeredValue NOT IN
                ('WORK_OWNER_UPDATED', 'DOC_ARTIFACT_CRUD', 'DUE_DATE_UPDATED', 'PERSONA_ASSIGNMENT_UPDATED')));

DELETE FROM alerttrigger WHERE triggeredValue IN ('WORK_OWNER_UPDATED', 'DOC_ARTIFACT_CRUD', 'DUE_DATE_UPDATED', 'PERSONA_ASSIGNMENT_UPDATED');

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1_7', 'fortify', 'dbF360_21.1.xml', NOW(), 679, '8:9a5a34a89f08a02b6ea48e64484185c8', 'delete tableName=alert; delete tableName=alerttrigger', 'Remove unused governance alerts', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1_8::fortify
--  Remove unused flex batch bug alerts
DELETE FROM alert WHERE EXISTS(SELECT 1 FROM alerttrigger atr WHERE (alert.id = atr.alert_id))
                AND
                NOT EXISTS(SELECT 1 FROM alerttrigger atr WHERE (alert.id = atr.alert_id AND atr.triggeredValue NOT IN ('BATCH_BUG_FILING_REQUESTED', 'BATCH_BUG_FILING_REQUEST_FAILED', 'BATCH_BUG_FILING_ENDED', 'BATCH_BUG_FILING_STARTED', 'BATCH_BUG_FILING_FAILED')));

DELETE FROM alerttrigger WHERE triggeredValue IN ('BATCH_BUG_FILING_REQUESTED', 'BATCH_BUG_FILING_REQUEST_FAILED', 'BATCH_BUG_FILING_ENDED', 'BATCH_BUG_FILING_STARTED', 'BATCH_BUG_FILING_FAILED');

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1_8', 'fortify', 'dbF360_21.1.xml', NOW(), 681, '8:fead3952844a8762392a6543439965af', 'delete tableName=alert; delete tableName=alerttrigger', 'Remove unused flex batch bug alerts', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1_9::fortify
--  Change guid for CWE Top 25 2019 reportdefinition
UPDATE reportdefinition SET guid = 'CWE_Top_25' WHERE guid = '7AF935C9-15AA-45B2-8EEC-0EAE4194ACDE';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1_9', 'fortify', 'dbF360_21.1.xml', NOW(), 683, '8:f37f5add4712c003830fab6dd8f6bf21', 'update tableName=reportdefinition', 'Change guid for CWE Top 25 2019 reportdefinition', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1_10::fortify
--  cacheEvictionTime field is never used in code
ALTER TABLE ldapserver DROP COLUMN cacheEvictionTime;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1_10', 'fortify', 'dbF360_21.1.xml', NOW(), 685, '8:60945f2bf3490224bbc71f97110e35f1', 'dropColumn columnName=cacheEvictionTime, tableName=ldapserver', 'cacheEvictionTime field is never used in code', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1.11::fortify
--  Remove unused attribute userOnly
ALTER TABLE permission DROP COLUMN userOnly;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1.11', 'fortify', 'dbF360_21.1.xml', NOW(), 687, '8:d7f2bbaae4a4acb4e6f6f877eb891b6c', 'dropColumn columnName=userOnly, tableName=permission', 'Remove unused attribute userOnly', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1_12::fortify
--  Improve deletable property calculation for custom tags
CREATE INDEX project_ver_attr_idx ON projectversion_attr(attrGuid);

CREATE INDEX project_tpl_attr_idx ON projecttemplate_attr(attrGuid);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1_12', 'fortify', 'dbF360_21.1.xml', NOW(), 689, '8:b45417bb5903ea7e76d63f71e9d52f8f', 'createIndex indexName=project_ver_attr_idx, tableName=projectversion_attr; createIndex indexName=project_tpl_attr_idx, tableName=projecttemplate_attr', 'Improve deletable property calculation for custom tags', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1_13::fortify
--  Add tables and additional fields for SCIM protocol support
ALTER TABLE fortifyuser ADD externalId VARCHAR(255) NULL, ADD externallyManaged CHAR(1) DEFAULT 'N' NOT NULL, ADD created datetime NULL, ADD lastModified datetime NULL;

ALTER TABLE fortifyuser ALTER externallyManaged DROP DEFAULT;

UPDATE fortifyuser SET created = CAST('1970-01-01' AS datetime(3)) WHERE created IS NULL;

ALTER TABLE fortifyuser MODIFY created datetime NOT NULL;

UPDATE fortifyuser SET lastModified = CAST('1970-01-01' AS datetime(3)) WHERE lastModified IS NULL;

ALTER TABLE fortifyuser MODIFY lastModified datetime NOT NULL;

CREATE TABLE fortifygroup (name VARCHAR(255) NOT NULL, id INT NOT NULL, externalId VARCHAR(255) NULL, externallyManaged CHAR(1) NOT NULL, created datetime NOT NULL, lastModified datetime NOT NULL, CONSTRAINT PK_FORTIFYGROUP PRIMARY KEY (id));

ALTER TABLE fortifygroup ADD CONSTRAINT RefSEFortifyGroup FOREIGN KEY (id) REFERENCES securityentity (id) ON DELETE CASCADE;

CREATE TABLE fortifygroup_securityentity (fortifyGroupId INT NOT NULL, memberSecurityEntityId INT NOT NULL, memberEntityTypeId INT NOT NULL, CONSTRAINT PK_FORTIFYGROUP_SECURITYENTITY PRIMARY KEY (fortifyGroupId, memberSecurityEntityId));

ALTER TABLE fortifygroup_securityentity ADD CONSTRAINT FK_fortifygroup_securityentity_group FOREIGN KEY (fortifyGroupId) REFERENCES fortifygroup (id);

ALTER TABLE fortifygroup_securityentity ADD CONSTRAINT FK_fortifygroup_securityentity_member FOREIGN KEY (memberSecurityEntityId) REFERENCES securityentity (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1_13', 'fortify', 'dbF360_21.1.xml', NOW(), 691, '8:d0de3da480854408a694225ae33fdeb0', 'addColumn tableName=fortifyuser; dropDefaultValue columnName=externallyManaged, tableName=fortifyuser; update tableName=fortifyuser; addNotNullConstraint columnName=created, tableName=fortifyuser; update tableName=fortifyuser; addNotNullConstraint...', 'Add tables and additional fields for SCIM protocol support', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.1.xml::f360_21.1_14::fortify
--  Change user type from SSO to LOCAL
UPDATE fortifyuser SET userType = 'LOCAL' WHERE userType='SSO' AND password IS NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.1_14', 'fortify', 'dbF360_21.1.xml', NOW(), 693, '8:b9046a68c4f1750152d48f25e398bfa2', 'update tableName=fortifyuser', 'Change user type from SSO to LOCAL', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.2.xml::f360_21.2_1::fortify
--  Add create time for job
ALTER TABLE jobqueue ADD createTime datetime NULL;

UPDATE jobqueue SET createTime = CAST('1970-01-01' AS datetime(3)) WHERE createTime IS NULL;

ALTER TABLE jobqueue MODIFY createTime datetime NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.2_1', 'fortify', 'dbF360_21.2.xml', NOW(), 695, '8:391b12e29c747d5d9848bd3dbe82229a', 'addColumn tableName=jobqueue; update tableName=jobqueue; addNotNullConstraint columnName=createTime, tableName=jobqueue', 'Add create time for job', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.2.xml::f360_21.2_2::fortify
--  Add new columns to support ldap server type, and enable mapping of ldap user status flags based on ldap attributes
ALTER TABLE ldapserver ADD ldapServerType VARCHAR(50) DEFAULT 'OTHER' NOT NULL, ADD enableUserStatusMapping VARCHAR(1) DEFAULT 'N' NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.2_2', 'fortify', 'dbF360_21.2.xml', NOW(), 697, '8:22dca82eb0ff10bd5247fc42dea8c331', 'addColumn tableName=ldapserver', 'Add new columns to support ldap server type, and enable mapping of ldap user status flags based on ldap attributes', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.2.xml::f360_21.2_3::fortify
delete from projectstateactivity where measurement_id not in (select id from measurement);

ALTER TABLE projectstateactivity ADD CONSTRAINT RefMeasProjStat FOREIGN KEY (measurement_id) REFERENCES measurement (id) ON DELETE CASCADE;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.2_3', 'fortify', 'dbF360_21.2.xml', NOW(), 699, '8:911b44c49fe8a7808d511e7e5d2031b3', 'sql; addForeignKeyConstraint baseTableName=projectstateactivity, constraintName=RefMeasProjStat, referencedTableName=measurement', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.2.xml::f360_21.2_4::fortify
ALTER TABLE sourcefilemap ADD fileType VARCHAR(50) NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.2_4', 'fortify', 'dbF360_21.2.xml', NOW(), 701, '8:10888370c8058c757abba8da25035683', 'addColumn tableName=sourcefilemap', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.2.xml::f360_21.2_5::fortify
--  Add cancel requested flag for job
ALTER TABLE jobqueue ADD cancelRequested CHAR(1) DEFAULT 'N' NOT NULL;

ALTER TABLE jobqueue ALTER cancelRequested DROP DEFAULT;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.2_5', 'fortify', 'dbF360_21.2.xml', NOW(), 703, '8:ae47b04baf9f060181132da783b2e9d9', 'addColumn tableName=jobqueue; dropDefaultValue columnName=cancelRequested, tableName=jobqueue', 'Add cancel requested flag for job', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_21.2.xml::f360_21.2_6::fortify
--  source - WIE, target - SCA
CREATE TABLE scan_issue_correlation (projectVersion_id INT NOT NULL, source_scan_id INT NOT NULL, source_scan_guid VARCHAR(255) NULL, source_engineType VARCHAR(20) NOT NULL, source_iid VARCHAR(80) NOT NULL, target_scan_guid VARCHAR(255) NULL, target_scan_time datetime NULL, target_engineType VARCHAR(20) NULL, target_iid VARCHAR(80) NULL);

CREATE INDEX SICORRELATION_IDX ON scan_issue_correlation(projectVersion_id, source_scan_id, source_engineType, source_iid, target_engineType, target_iid);

CREATE TABLE issue_correlation (projectVersion_id INT NOT NULL, source_issue_id INT NOT NULL, target_issue_id INT NOT NULL);

CREATE UNIQUE INDEX ISSUE_CORRELATION_IDX ON issue_correlation(projectVersion_id, source_issue_id, target_issue_id);

CREATE INDEX ISSUE_CORRELATION_TARGET_IDX ON issue_correlation(projectVersion_id, target_issue_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_21.2_6', 'fortify', 'dbF360_21.2.xml', NOW(), 705, '8:14081424615056d9457314a3af83cf59', 'createTable tableName=scan_issue_correlation; createIndex indexName=SICORRELATION_IDX, tableName=scan_issue_correlation; createTable tableName=issue_correlation; createIndex indexName=ISSUE_CORRELATION_IDX, tableName=issue_correlation; createIndex...', 'source - WIE, target - SCA', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_22.1.xml::f360_22.1_1::fortify
--  Add index for report.generationDate to help with filtering
CREATE INDEX REPORT_GENDATE_IDX ON savedreport(generationDate);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_22.1_1', 'fortify', 'dbF360_22.1.xml', NOW(), 707, '8:ba663e02e626faf9bc86f8bf5069854f', 'createIndex indexName=REPORT_GENDATE_IDX, tableName=savedreport', 'Add index for report.generationDate to help with filtering', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_22.1.xml::f360_22.1_2::fortify
--  Add iids and engineTypes of correlated issues, so they can be used to identify the issues.  Also add new indexes
ALTER TABLE issue_correlation ADD source_iid VARCHAR(80) NULL, ADD source_engineType VARCHAR(20) NULL, ADD target_iid VARCHAR(80) NULL, ADD target_engineType VARCHAR(20) NULL;

CREATE INDEX ISSUE_CORRELATION_TARGET_ID_IDX ON issue_correlation(target_issue_id);

CREATE INDEX ISSUE_CORRELATION_SOURCE_ID_IDX ON issue_correlation(source_issue_id);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_22.1_2', 'fortify', 'dbF360_22.1.xml', NOW(), 709, '8:dba5a67707d26a933e4382a948e57758', 'addColumn tableName=issue_correlation; createIndex indexName=ISSUE_CORRELATION_TARGET_ID_IDX, tableName=issue_correlation; createIndex indexName=ISSUE_CORRELATION_SOURCE_ID_IDX, tableName=issue_correlation', 'Add iids and engineTypes of correlated issues, so they can be used to identify the issues.  Also add new indexes', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_22.1.xml::f360_22.1_3::fortify
--  Flag used to specify if a custom tag requires a comment on value change
ALTER TABLE attr ADD requiresComment VARCHAR(1) DEFAULT 'N' NOT NULL;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_22.1_3', 'fortify', 'dbF360_22.1.xml', NOW(), 711, '8:98a4a3cd16cd47e30d69e1dc0025960c', 'addColumn tableName=attr', 'Flag used to specify if a custom tag requires a comment on value change', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360_22.1.xml::f360_22.1_4_mysql::fortify
--  Re-purpose unused and always empty tempInstanceId to store original issue priority when priority is overridden by user (MySQL)
ALTER TABLE issue CHANGE tempInstanceId enginePriority VARCHAR(80);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360_22.1_4_mysql', 'fortify', 'dbF360_22.1.xml', NOW(), 713, '8:3744f1767defaac29122357e5666ad89', 'renameColumn newColumnName=enginePriority, oldColumnName=tempInstanceId, tableName=issue', 'Re-purpose unused and always empty tempInstanceId to store original issue priority when priority is overridden by user (MySQL)', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset dbF360Mysql_22.1_correlation.xml::f360Mysql_22.1_correlation::fortify
UPDATE issue_correlation ic INNER JOIN issue i ON ic.source_issue_id = i.id SET ic.source_iid = i.issueInstanceId, ic.source_engineType = i.engineType;

UPDATE issue_correlation ic INNER JOIN issue i ON ic.target_issue_id = i.id SET ic.target_iid = i.issueInstanceId, ic.target_engineType = i.engineType;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('f360Mysql_22.1_correlation', 'fortify', 'dbF360Mysql_22.1_correlation.xml', NOW(), 715, '8:ebe1f29aad9c6b9ad3cec049e6f781f8', 'sql; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset views/dbF360_baseissueview.xml::baseissueview::hp
CREATE OR REPLACE VIEW baseissueview AS SELECT
                i.id,
                i.folder_id,
                i.issueInstanceId,
                i.fileName,
                i.shortFileName,
                i.severity,
                i.ruleGuid,
                i.confidence,
                i.kingdom,
                i.issueType,
                i.issueSubtype,
                i.analyzer,
                i.lineNumber,
                i.taintFlag,
                i.packageName,
                i.functionName,
                i.className,
                i.issueAbstract,
                i.issueRecommendation,
                i.friority,
                i.engineType,
                i.scanStatus,
                i.audienceSet,
                i.lastScan_id,
                i.replaceStore,
                i.snippetId,
                i.url,
                i.category,
                i.source,
                i.sourceContext,
                i.sourceFile,
                i.sink,
                i.sinkContext,
                i.userName,
                i.revision,
                i.audited,
                i.auditedTime,
                i.suppressed,
                i.findingGuid,
                i.issueStatus,
                i.issueState,
                i.dynamicConfidence,
                i.minVirtualCallConfidence,
                i.remediationConstant,
                i.projectVersion_id,
                i.hidden,
                i.likelihood,
                i.impact,
                i.accuracy,
                i.rtaCovered,
                i.probability,
                i.foundDate,
                i.removedDate,
                i.requestHeader,
                i.requestParameter,
                i.requestBody,
                i.attackPayload,
                i.attackType,
                i.response,
                i.triggerDefinition,
                i.triggerString,
                i.triggerDisplayText,
                i.secondaryRequest,
                i.sourceLine,
                i.requestMethod,
                i.httpVersion,
                i.cookie,
                i.mappedCategory,
                i.correlated,
                i.correlationSetGuid,
                i.attackTriggerDefinition,
                i.vulnerableParameter,
                i.reproStepDefinition,
                i.stackTrace,
                i.stackTraceTriggerDisplayText,
                i.bug_id,
                i.manual
            FROM issue i;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('baseissueview', 'hp', 'views/dbF360_baseissueview.xml', NOW(), 717, '8:4e2e6fb50dcb57d48121ee79aa5a584e', 'createView viewName=baseissueview', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset views/dbF360_defaultissueview_standards.xml::defaultissueview_standards::hp
CREATE OR REPLACE VIEW defaultissueview AS SELECT
                i.id,
                i.folder_id,
                i.issueInstanceId,
                i.fileName,
                i.shortFileName,
                i.severity,
                i.ruleGuid,
                i.confidence,
                i.kingdom,
                i.issueType,
                i.issueSubtype,
                i.analyzer,
                i.lineNumber,
                i.taintFlag,
                i.packageName,
                i.functionName,
                i.className,
                i.issueAbstract,
                i.issueRecommendation,
                i.friority,
                i.engineType,
                i.scanStatus,
                i.audienceSet,
                i.lastScan_id,
                i.replaceStore,
                i.snippetId,
                i.url,
                i.category,
                i.source,
                i.sourceContext,
                i.sourceFile,
                i.sink,
                i.sinkContext,
                i.userName,
                i.revision,
                i.audited,
                i.auditedTime,
                i.suppressed,
                i.findingGuid,
                i.issueStatus,
                i.issueState,
                i.dynamicConfidence,
                i.minVirtualCallConfidence,
                i.remediationConstant,
                i.projectVersion_id,
                i.hidden,
                i.likelihood,
                i.impact,
                i.accuracy,
                i.rtaCovered,
                i.probability,
                i.foundDate,
                i.removedDate,
                i.requestHeader,
                i.requestParameter,
                i.requestBody,
                i.attackPayload,
                i.attackType,
                i.response,
                i.triggerDefinition,
                i.triggerString,
                i.triggerDisplayText,
                i.secondaryRequest,
                i.sourceLine,
                i.requestMethod,
                i.httpVersion,
                i.cookie,
                i.mappedCategory,
                i.correlated,
                i.attackTriggerDefinition,
                i.vulnerableParameter,
                i.reproStepDefinition,
                i.stackTrace,
                i.stackTraceTriggerDisplayText,
                i.bug_id,
                i.manual,
                getExternalCategories(i.mappedCategory, '771C470C-9274-4580-8556-C023E4D3ADB4') AS owasp2004,
                getExternalCategories(i.mappedCategory, '1EB1EC0E-74E6-49A0-BCE5-E6603802987A') AS owasp2007,
                getExternalCategories(i.mappedCategory, 'FDCECA5E-C2A8-4BE8-BB26-76A8ECD0ED59') AS owasp2010,
                getExternalCategories(i.mappedCategory, '3ADB9EE4-5761-4289-8BD3-CBFCC593EBBC') AS cwe,
                getExternalCategories(i.mappedCategory, '939EF193-507A-44E2-ABB7-C00B2168B6D8') AS sans25,
                getExternalCategories(i.mappedCategory, '72688795-4F7B-484C-88A6-D4757A6121CA') AS sans2010,
                getExternalCategories(i.mappedCategory, '9DC61E7F-1A48-4711-BBFD-E9DFF537871F') AS wasc,
                getExternalCategories(i.mappedCategory, 'F2FA57EA-5AAA-4DDE-90A5-480BE65CE7E7') AS stig,
                getExternalCategories(i.mappedCategory, '58E2C21D-C70F-4314-8994-B859E24CF855') AS stig34,
                getExternalCategories(i.mappedCategory, 'CBDB9D4D-FC20-4C04-AD58-575901CAB531') AS pci11,
                getExternalCategories(i.mappedCategory, '57940BDB-99F0-48BF-BF2E-CFC42BA035E5') AS pci12,
                getExternalCategories(i.mappedCategory, '8970556D-7F9F-4EA7-8033-9DF39D68FF3E') AS pci20,
                getExternalCategories(i.mappedCategory, 'B40F9EE0-3824-4879-B9FE-7A789C89307C') AS fisma
            FROM issue i;

CREATE OR REPLACE VIEW view_standards AS SELECT
                i.folder_id,
                i.id,
                i.issueInstanceId,
                i.fileName,
                i.shortFileName,
                i.severity,
                i.ruleGuid,
                i.confidence,
                i.kingdom,
                i.issueType,
                i.issueSubtype,
                i.analyzer,
                i.lineNumber,
                i.taintFlag,
                i.packageName,
                i.functionName,
                i.className,
                i.issueAbstract,
                i.issueRecommendation,
                i.friority,
                i.engineType,
                i.scanStatus,
                i.audienceSet,
                i.lastScan_id,
                i.replaceStore,
                i.snippetId,
                i.url,
                i.category,
                i.source,
                i.sourceContext,
                i.sourceFile,
                i.sink,
                i.sinkContext,
                i.userName,
                i.owasp2004,
                i.owasp2007,
                i.cwe,
                i.revision,
                i.audited,
                i.auditedTime,
                i.suppressed,
                i.findingGuid,
                i.issueStatus,
                i.issueState,
                i.dynamicConfidence,
                i.minVirtualCallConfidence,
                i.remediationConstant,
                i.projectVersion_id,
                i.hidden,
                i.likelihood,
                i.impact,
                i.accuracy,
                i.wasc,
                i.sans25 AS sans2009,
                i.stig,
                i.pci11,
                i.pci12,
                i.rtaCovered,
                i.probability,
                i.foundDate,
                i.removedDate,
                i.requestHeader,
                i.requestParameter,
                i.requestBody,
                i.attackPayload,
                i.attackType,
                i.attackTriggerDefinition,
                i.response,
                i.triggerDefinition,
                i.triggerString,
                i.triggerDisplayText,
                i.secondaryRequest,
                i.sourceLine,
                i.requestMethod,
                i.httpVersion,
                i.cookie,
                i.mappedCategory,
                i.owasp2010,
                i.fisma AS fips200,
                i.sans2010,
                i.correlated,
                i.pci20,
                i.vulnerableParameter,
                i.reproStepDefinition,
                i.stackTrace,
                i.stackTraceTriggerDisplayText
            FROM defaultissueview i
            WHERE i.hidden='N'
                AND i.suppressed='N'
                AND i.scanStatus <> 'REMOVED'
                AND (
                    (i.owasp2010 IS NOT NULL and upper(i.owasp2010) <> 'NONE')
                    OR (i.fisma IS NOT NULL AND upper(i.fisma) <> 'NONE')
                    OR (i.sans25 IS NOT NULL AND upper(i.sans25) <> 'NONE')
                    OR (i.sans2010 IS NOT NULL AND upper(i.sans2010) <> 'NONE')
                    OR (i.pci20 IS NOT NULL AND upper(i.pci20) <> 'NONE')
                );

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('defaultissueview_standards', 'hp', 'views/dbF360_defaultissueview_standards.xml', NOW(), 719, '8:77fe3f0df5a32d69b1be1f4a91a40d6c', 'createView viewName=defaultissueview; createView viewName=view_standards', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset views/dbF360_measurementAgentInUseView.xml::measurementAgentInUseViewCreate::hp
CREATE OR REPLACE VIEW measurementAgentInUseView AS select monitoredInstanceId as measurement_id
            from alert
            where monitoredEntityType = 'MEASUREMENT_AGENT';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('measurementAgentInUseViewCreate', 'hp', 'views/dbF360_measurementAgentInUseView.xml', NOW(), 721, '8:7e872814f97e5950579e70673925f030', 'createView viewName=measurementAgentInUseView', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset views/dbF360_variableInUseView.xml::variableInUseViewCreate::hp
CREATE OR REPLACE VIEW variableInUseView AS select variable_id
            from measurement_variable
            union all
            select monitoredInstanceId as variable_id
            from alert
            where monitoredEntityType = 'VARIABLE';

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('variableInUseViewCreate', 'hp', 'views/dbF360_variableInUseView.xml', NOW(), 723, '8:713036d078bd78ec7699abe38373bb74', 'createView viewName=variableInUseView', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset views/dbF360_metadefview.xml::metadefview::hp
CREATE OR REPLACE VIEW metadefview AS SELECT def.id id, def.metaType metaType, def.seqNumber seqNumber, def.required required, def.category category,
 			    def.hidden hidden, def.booleanDefault booleanDefault, def.guid guid, def.parent_id parent_id,
 			    def.systemUsage systemUsage, t.name name, t.description description, t.help help, t.lang lang,
 			    def.parentOption_id, def.appEntityType, def.objectVersion, def.publishVersion
			FROM metadef def, metadef_t t
			WHERE def.id =  t.metaDef_id  AND t.metaDef_id = def.id;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('metadefview', 'hp', 'views/dbF360_metadefview.xml', NOW(), 725, '8:e7b64ecee0675394de65e22ce11ab3e2', 'createView viewName=metadefview', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset views/dbF360_externalcatorderview.xml::externalcatorderview::hp
CREATE OR REPLACE VIEW externalCatOrderView AS select cl.mappedCategory, cec.catPackExternalList_id, max(cl.orderingInfo) as orderingInfo
            from catpacklookup cl, catpackexternalcategory cec
            where cl.catPackExternalCategory_id = cec.id
            group by cl.mappedCategory, cec.catPackExternalList_id;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('externalcatorderview', 'hp', 'views/dbF360_externalcatorderview.xml', NOW(), 727, '8:f0ec57924a1b5139036f0a1aa9e0465c', 'createView viewName=externalCatOrderView', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset views/dbF360_auditvalueview.xml::auditvalueview::hp
CREATE OR REPLACE VIEW auditvalueview AS SELECT a.projectVersion_id,
                   a.issue_id,
                   a.attrGuid,
                   a.attrValue lookupIndex,
                   l.lookupValue,
				   a.decimalValue,
				   a.dateValue,
				   a.textValue,
                   attr.attrName,
                   attr.defaultValue,
                   attr.hidden,
                   attr.valueType,
                   l.seqNumber,
                   attr.restriction
            from auditvalue a
			join attr on a.attrGuid = attr.guid
            left join attrlookup l on attr.id = l.attr_id and l.lookupIndex = a.attrValue;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('auditvalueview', 'hp', 'views/dbF360_auditvalueview.xml', NOW(), 729, '8:036d8fb1919ed03d2b3f2545416f8250', 'createView viewName=auditvalueview', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset views/dbF360_attrLookupInUseView.xml::attrLookupInUseView_mysql::hp
CREATE OR REPLACE VIEW attrlookupinuseview AS select attr_id, lookupIndex
            from attrlookup al
            where exists (select 1 from auditvalue av where av.attrValue = al.lookupIndex and av.attrGuid = al.attrGuid LIMIT 0, 1);

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('attrLookupInUseView_mysql', 'hp', 'views/dbF360_attrLookupInUseView.xml', NOW(), 731, '8:29d84dad5c79e3a0927c1df1173895d0', 'createView viewName=attrlookupinuseview', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset views/dbF360_scanissueview.xml::scanissueview::hp
CREATE OR REPLACE VIEW scanissueview AS SELECT si.projectVersion_id, si.scan_id, si.id, si.issue_id, si.issueInstanceId,
            s.startDate, s.engineType
            FROM scan_issue si INNER JOIN scan s ON si.scan_id = s.id;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('scanissueview', 'hp', 'views/dbF360_scanissueview.xml', NOW(), 733, '8:7b07851a11d66d66146a1255f27e4cbc', 'createView viewName=scanissueview', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset views/dbF360_ruleview.xml::ruleview::fortify
CREATE OR REPLACE VIEW ruleview AS SELECT p.projectVersion_id as projectVersion_id, r.id as id, r.guid as descGuid, p.ruleGuid as ruleGuid, r.rulepack_id as rulepack_id, t.lang as lang, t.detail as detail, t.recommendation as recommendation, t.ruleAbstract as ruleAbstract, t.rawDetail as rawDetail, t.rawRecommendation as rawRecommendation, t.rawRuleAbstract as rawRuleAbstract, t.tips as tips, t.refers as refers, t.customHeader as customHeader
            FROM ruledescription r, rule_t t, projectversion_rule p
            where r.id = t.id AND p.rule_id = r.id;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('ruleview', 'fortify', 'views/dbF360_ruleview.xml', NOW(), 735, '8:6cfa00c0ef011fb87056395637d20d54', 'createView viewName=ruleview', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset views/dbF360_audithistoryview.xml::audithistoryview::fortify
CREATE OR REPLACE VIEW audithistoryview AS SELECT h.issue_id,
                   h.seqNumber,
                   h.attrGuid,
                   h.auditTime,
                   h.oldValue,
                   h.newValue,
                   h.projectVersion_id,
                   h.userName,
                   h.conflict,
                   a.attrName,
                   a.defaultValue,
                   a.valueType
            from audithistory h
            LEFT OUTER JOIN attr a ON h.attrGuid = a.guid;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('audithistoryview', 'fortify', 'views/dbF360_audithistoryview.xml', NOW(), 737, '8:da2f1635bfa9a010b073aa828841c4d9', 'createView viewName=audithistoryview', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset views/dbF360_applicationentityview.xml::applicationentityview::fortify
--  Remove union of dataset from runtimeapplication table
CREATE OR REPLACE VIEW applicationentityview AS SELECT a.id id, p.name name,a.appEntityType
             FROM applicationentity a, projectversion p
             WHERE a.id = p.id;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('applicationentityview', 'fortify', 'views/dbF360_applicationentityview.xml', NOW(), 739, '8:1bdf0ca7fea9aa19be96ba84d8f1552e', 'createView viewName=applicationentityview', 'Remove union of dataset from runtimeapplication table', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset procs/dbF360_updateScanIssueIds.xml::updateScanIssueIds_mysql::hp_main
DROP PROCEDURE IF EXISTS updateScanIssueIds;

DELIMITER //
CREATE PROCEDURE updateScanIssueIds	(p_scan_id INT,
	 p_projectVersion_id INT,
	 p_engineType varchar(20)
	)
BEGIN
	UPDATE scan_issue si, issue
	SET si.issue_id=issue.id
	WHERE issue.projectVersion_id = p_projectVersion_id
	  AND issue.engineType = p_engineType
	  AND si.issueInstanceId = issue.issueInstanceId
	  AND si.scan_id = p_scan_id
	  AND si.issue_id IS NULL;
END//
DELIMITER ;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('updateScanIssueIds_mysql', 'hp_main', 'procs/dbF360_updateScanIssueIds.xml', NOW(), 741, '8:71af8d758f2e0272815083ba9745d137', 'sql; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset procs/dbF360_updateIssuesFromFilterSet.xml::updateIssuesFromFilterSet_mysql::hp_main
DROP PROCEDURE IF EXISTS updateIssuesFromFilterSet;

DELIMITER //
CREATE PROCEDURE updateIssuesFromFilterSet (		p_projectVersion_id INT,
		p_filterSet_id INT
	)
BEGIN
	UPDATE issue i, issuecache ic
	SET i.hidden = ic.hidden, i.folder_id = ic.folder_id
	WHERE i.projectVersion_id = p_projectVersion_id
		AND ic.projectVersion_id = p_projectVersion_id
		AND ic.filterSet_id = p_filterSet_id
		AND ic.issue_id = i.id
		AND (i.hidden <> ic.hidden OR i.folder_id IS NULL OR i.folder_id <> ic.folder_id);
END//
DELIMITER ;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('updateIssuesFromFilterSet_mysql', 'hp_main', 'procs/dbF360_updateIssuesFromFilterSet.xml', NOW(), 743, '8:5b902fc229efe36b4304315a4d56e4f9', 'sql; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset procs/dbF360_updateExistingWithLatest.xml::updateExistingWithLatest_mysql::hp_main
DROP PROCEDURE IF EXISTS updateExistingWithLatest;

DELIMITER //
CREATE PROCEDURE updateExistingWithLatest    (p_scan_id INT,
     p_projectVersion_id INT,
     p_foundDate BIGINT,
     p_folder_id INT,
     p_customPriorityEnabled INT
    )
BEGIN
    insert into issue (lastScan_Id, scanStatus, issueInstanceId, projectVersion_Id, engineType 
        , foundDate, shortFileName, fileName, severity, confidence, kingdom
        , issueType, issueSubtype, analyzer, lineNumber, taintFlag, packageName
        , functionName, className, issueAbstract, issueRecommendation, friority
        , replaceStore, ruleGuid, findingGuid, snippetId, contextId, category
        , url, source, sourceContext, sink, sinkContext, sourceFile
        , audienceSet, remediationConstant, likelihood, probability, impact
        , accuracy, rtaCovered, requestIdentifier, requestHeader, requestParameter
        , requestBody, requestMethod, cookie, httpVersion, attackPayload, attackType
        , attackTriggerDefinition , response, triggerDefinition, triggerString
        , triggerDisplayText, secondaryRequest, sourceLine, mappedCategory
        , vulnerableParameter, reproStepDefinition, stackTrace, stackTraceTriggerDisplayText
        , manual, minVirtualCallConfidence, hidden, folder_Id, objectVersion)
	select scan_Id, 'NEW', issueInstanceId, projectVersion_Id, engineType, p_foundDate
        , shortFileName, fileName, severity, confidence, kingdom, issueType, issueSubtype
        , analyzer, lineNumber, taintFlag, packageName, functionName, className, issueAbstract
        , issueRecommendation, friority, replaceStore, ruleGuid, findingGuid, snippetId, contextId
        , category, url, source, sourceContext, sink, sinkContext, sourceFile, audienceSet
        , remediationConstant, likelihood, probability, impact, accuracy, rtaCovered
        , requestIdentifier, requestHeader, requestParameter, requestBody, requestMethod, cookie
        , httpVersion, attackPayload, attackType, attackTriggerDefinition, response
        , triggerDefinition, triggerString, triggerDisplayText, secondaryRequest, sourceLine
        , mappedCategory, vulnerableParameter, reproStepDefinition, stackTrace
        , stackTraceTriggerDisplayText, manual, minVirtualCallConfidence, 'N', p_folder_id, 0 from scan_issue si where si.projectVersion_id = p_projectVersion_id and si.scan_id = p_scan_id
	 on duplicate key update issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation
        , issue.friority = (case when p_customPriorityEnabled = 0 or issue.enginePriority is null then si.friority else issue.friority end)
        , issue.enginePriority = (case when p_customPriorityEnabled = 0 or issue.enginePriority is null then null else si.friority end)
	    , issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.scanStatus = (CASE WHEN issue.scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        , issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
        , issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
        , issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        , issue.minVirtualCallConfidence=si.minVirtualCallConfidence;

    insert into issue_ca (issue_id, projectVersion_id, issueInstanceId, engineType, dataVersion, metadataPluginId,
			integerValue01, integerValue02, integerValue03, decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
			dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
			textValue01, textValue02, textValue03, textValue04, textValue05, textValue06, textValue07, textValue08, textValue09, textValue10, textValue11, textValue12, textValue13, textValue14, textValue15, textValue16,
			clobValue01, clobValue02, clobValue03, clobValue04, clobValue05, clobValue06)
	select i.id, sica.projectVersion_id, sica.issueInstanceId, sica.engineType, sica.dataVersion, sica.metadataPluginId,
			sica.integerValue01, sica.integerValue02, sica.integerValue03, sica.decimalValue01, sica.decimalValue02, sica.decimalValue03, sica.decimalValue04, sica.decimalValue05,
			sica.dateValue01, sica.dateValue02, sica.dateValue03, sica.dateValue04, sica.dateValue05,
			sica.textValue01, sica.textValue02, sica.textValue03, sica.textValue04, sica.textValue05, sica.textValue06, sica.textValue07, sica.textValue08, sica.textValue09, sica.textValue10, sica.textValue11, sica.textValue12, sica.textValue13, sica.textValue14, sica.textValue15, sica.textValue16,
			sica.clobValue01, sica.clobValue02, sica.clobValue03, sica.clobValue04, sica.clobValue05, sica.clobValue06
	    from scan_issue_ca sica
	    join issue i ON i.engineType=sica.engineType AND i.issueInstanceId=sica.issueInstanceId where sica.scan_id = p_scan_id AND sica.projectVersion_id = p_projectVersion_id AND i.projectVersion_id=p_projectVersion_id
	on duplicate key update issue_ca.issueInstanceId=sica.issueInstanceId, issue_ca.engineType=sica.engineType, issue_ca.dataVersion=sica.dataVersion,
			issue_ca.integerValue01=sica.integerValue01, issue_ca.integerValue02=sica.integerValue02, issue_ca.integerValue03=sica.integerValue03, issue_ca.decimalValue01=sica.decimalValue01, issue_ca.decimalValue02=sica.decimalValue02, issue_ca.decimalValue03=sica.decimalValue03, issue_ca.decimalValue04=sica.decimalValue04, issue_ca.decimalValue05=sica.decimalValue05,
			issue_ca.dateValue01=sica.dateValue01, issue_ca.dateValue02=sica.dateValue02, issue_ca.dateValue03=sica.dateValue03, issue_ca.dateValue04=sica.dateValue04, issue_ca.dateValue05=sica.dateValue05,
			issue_ca.textValue01=sica.textValue01, issue_ca.textValue02=sica.textValue02, issue_ca.textValue03=sica.textValue03, issue_ca.textValue04=sica.textValue04, issue_ca.textValue05=sica.textValue05, issue_ca.textValue06=sica.textValue06, issue_ca.textValue07=sica.textValue07, issue_ca.textValue08=sica.textValue08, issue_ca.textValue09=sica.textValue09, issue_ca.textValue10=sica.textValue10,
			issue_ca.textValue11=sica.textValue11, issue_ca.textValue12=sica.textValue12, issue_ca.textValue13=sica.textValue13, issue_ca.textValue14=sica.textValue14, issue_ca.textValue15=sica.textValue15, issue_ca.textValue16=sica.textValue16,
			issue_ca.clobValue01=sica.clobValue01, issue_ca.clobValue02=sica.clobValue02, issue_ca.clobValue03=sica.clobValue03, issue_ca.clobValue04=sica.clobValue04, issue_ca.clobValue05=sica.clobValue05, issue_ca.clobValue06=sica.clobValue06;

END//
DELIMITER ;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('updateExistingWithLatest_mysql', 'hp_main', 'procs/dbF360_updateExistingWithLatest.xml', NOW(), 745, '8:873ccf03d82e7f400181342e9d49b1b7', 'sql; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset procs/dbF360_updateDeletedIssues.xml::updateDeletedIssues_mysql::hp
DROP PROCEDURE IF EXISTS updateDeletedIssues;

DELIMITER //
CREATE PROCEDURE updateDeletedIssues    (p_scan_id INT,
     p_previous_scan_id INT,
     p_projectVersion_id INT,
     p_customPriorityEnabled INT
    )
BEGIN
    UPDATE issue issue, scan_issue si, issue_ca ica, scan_issue_ca sica
    SET ica.engineType=sica.engineType, ica.dataVersion=sica.dataVersion, ica.metadataPluginId=sica.metadataPluginId,
	    ica.integerValue01 = sica.integerValue01, ica.integerValue02 = sica.integerValue02, ica.integerValue03 = sica.integerValue03,
	    ica.decimalValue01 = sica.decimalValue01, ica.decimalValue02 = sica.decimalValue02, ica.decimalValue03 = sica.decimalValue03, ica.decimalValue04 = sica.decimalValue04, ica.decimalValue05 = sica.decimalValue05,
	    ica.dateValue01 = sica.dateValue01, ica.dateValue02 = sica.dateValue02, ica.dateValue03 = sica.dateValue03, ica.dateValue04 = sica.dateValue04, ica.dateValue05 = sica.dateValue05,
	    ica.textValue01 = sica.textValue01, ica.textValue02 = sica.textValue02, ica.textValue03 = sica.textValue03, ica.textValue04 = sica.textValue04, ica.textValue05 = sica.textValue05,
	    ica.textValue06 = sica.textValue06, ica.textValue07 = sica.textValue07, ica.textValue08 = sica.textValue08, ica.textValue09 = sica.textValue09, ica.textValue10 = sica.textValue10,
	    ica.textValue11 = sica.textValue11, ica.textValue12 = sica.textValue12, ica.textValue13 = sica.textValue13, ica.textValue14 = sica.textValue14, ica.textValue15 = sica.textValue15, ica.textValue16 = sica.textValue16,
	    ica.clobValue01 = sica.clobValue01, ica.clobValue02 = sica.clobValue02, ica.clobValue03 = sica.clobValue03, ica.clobValue04 = sica.clobValue04, ica.clobValue05 = sica.clobValue05, ica.clobValue06 = sica.clobValue06
    WHERE issue.projectVersion_id = p_projectVersion_id
        AND issue.lastScan_id = p_scan_id
        AND si.issue_id = issue.id
        AND si.scan_id = p_previous_scan_id
        AND ica.issue_id = issue.id
        AND sica.issueInstanceId = si.issueInstanceId
        AND sica.scan_id = si.scan_id;

    INSERT into issue_ca (issue_id, projectVersion_id, issueInstanceId, engineType, dataVersion, metadataPluginId,
			integerValue01, integerValue02, integerValue03, decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
			dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
			textValue01, textValue02, textValue03, textValue04, textValue05, textValue06, textValue07, textValue08, textValue09, textValue10, textValue11, textValue12, textValue13, textValue14, textValue15, textValue16,
			clobValue01, clobValue02, clobValue03, clobValue04, clobValue05, clobValue06)
	    SELECT i.id, sica.projectVersion_id, sica.issueInstanceId, sica.engineType, sica.dataVersion, sica.metadataPluginId,
			sica.integerValue01, sica.integerValue02, sica.integerValue03, sica.decimalValue01, sica.decimalValue02, sica.decimalValue03, sica.decimalValue04, sica.decimalValue05,
			sica.dateValue01, sica.dateValue02, sica.dateValue03, sica.dateValue04, sica.dateValue05,
			sica.textValue01, sica.textValue02, sica.textValue03, sica.textValue04, sica.textValue05, sica.textValue06, sica.textValue07, sica.textValue08, sica.textValue09, sica.textValue10, sica.textValue11, sica.textValue12, sica.textValue13, sica.textValue14, sica.textValue15, sica.textValue16,
			sica.clobValue01, sica.clobValue02, sica.clobValue03, sica.clobValue04, sica.clobValue05, sica.clobValue06
	    FROM scan_issue_ca sica
	    join scan_issue si ON sica.issueInstanceId=si.issueInstanceId AND sica.scan_id=si.scan_id
	    join issue i ON i.id = si.issue_id
	    WHERE i.lastScan_id = p_scan_id
	      AND i.projectVersion_id = p_projectVersion_id
	      AND si.scan_id = p_previous_scan_id
	      AND NOT EXISTS (SELECT 1 FROM issue_ca ica WHERE ica.issue_id = i.id);

    DELETE ica FROM issue_ca ica
        WHERE ica.projectVersion_id = p_projectVersion_id
        AND EXISTS (SELECT 1
                      from scan_issue si, issue i
                     WHERE si.issue_id = i.id
                       AND si.scan_id = p_previous_scan_id
                       AND i.lastScan_id = p_scan_id
                       AND si.projectVersion_id=p_projectVersion_id
                       AND si.issue_id = ica.issue_id
                       AND NOT EXISTS (SELECT 1 FROM scan_issue_ca WHERE issueInstanceId = si.issueInstanceId AND scan_id = si.scan_id));

    UPDATE issue issue, scan_issue si
    SET issue.lastScan_Id = si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation
        , issue.friority=(case when p_customPriorityEnabled = 0 or issue.enginePriority is null then si.friority else issue.friority end)
        , issue.enginePriority=(case when p_customPriorityEnabled = 0 or issue.enginePriority is null then null else si.friority end)
        , issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        , issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
        , issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
        , issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        , issue.minVirtualCallConfidence=si.minVirtualCallConfidence
    WHERE issue.projectVersion_id = p_projectVersion_id
        AND issue.lastScan_id = p_scan_id
        AND si.issue_id = issue.id
        AND si.scan_id = p_previous_scan_id;
END//
DELIMITER ;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('updateDeletedIssues_mysql', 'hp', 'procs/dbF360_updateDeletedIssues.xml', NOW(), 747, '8:8c7aa11120af4236483fd96d2bb4c23f', 'sql; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset procs/dbF360_updateRemovedWithUpload.xml::updateRemovedWithUpload_mysql::hp
DROP PROCEDURE IF EXISTS updateRemovedWithUpload;

DELIMITER //
CREATE PROCEDURE updateRemovedWithUpload    (p_scan_id INT,
     p_projectVersion_Id INT,
     p_engineType varchar(20),
     p_scanDate BIGINT,
     p_removedDate BIGINT,
     p_customPriorityEnabled INT
    )
BEGIN
    UPDATE issue issue, scan_issue si, scan scan, issue_ca ica, scan_issue_ca sica
    SET ica.engineType=sica.engineType, ica.dataVersion=sica.dataVersion, ica.metadataPluginId=sica.metadataPluginId,
	    ica.integerValue01 = sica.integerValue01, ica.integerValue02 = sica.integerValue02, ica.integerValue03 = sica.integerValue03,
	    ica.decimalValue01 = sica.decimalValue01, ica.decimalValue02 = sica.decimalValue02, ica.decimalValue03 = sica.decimalValue03, ica.decimalValue04 = sica.decimalValue04, ica.decimalValue05 = sica.decimalValue05,
	    ica.dateValue01 = sica.dateValue01, ica.dateValue02 = sica.dateValue02, ica.dateValue03 = sica.dateValue03, ica.dateValue04 = sica.dateValue04, ica.dateValue05 = sica.dateValue05,
	    ica.textValue01 = sica.textValue01, ica.textValue02 = sica.textValue02, ica.textValue03 = sica.textValue03, ica.textValue04 = sica.textValue04, ica.textValue05 = sica.textValue05,
	    ica.textValue06 = sica.textValue06, ica.textValue07 = sica.textValue07, ica.textValue08 = sica.textValue08, ica.textValue09 = sica.textValue09, ica.textValue10 = sica.textValue10,
	    ica.textValue11 = sica.textValue11, ica.textValue12 = sica.textValue12, ica.textValue13 = sica.textValue13, ica.textValue14 = sica.textValue14, ica.textValue15 = sica.textValue15, ica.textValue16 = sica.textValue16,
	    ica.clobValue01 = sica.clobValue01, ica.clobValue02 = sica.clobValue02, ica.clobValue03 = sica.clobValue03, ica.clobValue04 = sica.clobValue04, ica.clobValue05 = sica.clobValue05, ica.clobValue06 = sica.clobValue06
    WHERE issue.projectVersion_id = p_projectVersion_id
        AND issue.engineType = p_engineType
        AND si.scan_id = p_scan_id
        AND si.issueInstanceId = issue.issueInstanceId
        AND issue.scanStatus = 'REMOVED'
        AND issue.lastScan_id = scan.id
        AND scan.startDate < p_scanDate
        AND sica.issueInstanceId = si.issueInstanceId
        AND sica.scan_id = si.scan_id
        AND ica.issue_id = issue.id;

    INSERT into issue_ca (issue_id, projectVersion_id, issueInstanceId, engineType, dataVersion, metadataPluginId,
			integerValue01, integerValue02, integerValue03, decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
			dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
			textValue01, textValue02, textValue03, textValue04, textValue05, textValue06, textValue07, textValue08, textValue09, textValue10, textValue11, textValue12, textValue13, textValue14, textValue15, textValue16,
			clobValue01, clobValue02, clobValue03, clobValue04, clobValue05, clobValue06)
	    SELECT i.id, sica.projectVersion_id, sica.issueInstanceId, sica.engineType, sica.dataVersion, sica.metadataPluginId,
			sica.integerValue01, sica.integerValue02, sica.integerValue03, sica.decimalValue01, sica.decimalValue02, sica.decimalValue03, sica.decimalValue04, sica.decimalValue05,
			sica.dateValue01, sica.dateValue02, sica.dateValue03, sica.dateValue04, sica.dateValue05,
			sica.textValue01, sica.textValue02, sica.textValue03, sica.textValue04, sica.textValue05, sica.textValue06, sica.textValue07, sica.textValue08, sica.textValue09, sica.textValue10, sica.textValue11, sica.textValue12, sica.textValue13, sica.textValue14, sica.textValue15, sica.textValue16,
			sica.clobValue01, sica.clobValue02, sica.clobValue03, sica.clobValue04, sica.clobValue05, sica.clobValue06
	    FROM scan_issue_ca sica
	    join scan_issue si ON sica.issueInstanceId=si.issueInstanceId AND sica.scan_id=si.scan_id
	    join issue i ON i.id = si.issue_id join scan s ON i.lastScan_id=s.id
	    WHERE i.projectVersion_id = p_projectVersion_id AND si.scan_id = p_scan_id
	        AND NOT EXISTS (SELECT 1 FROM issue_ca ica WHERE ica.issue_id = i.id) AND i.scanStatus = 'REMOVED'
	        AND s.startDate < p_scanDate AND i.engineType = p_engineType;

    DELETE ica FROM issue_ca ica
        WHERE ica.projectVersion_id = p_projectVersion_id
          AND EXISTS (SELECT 1
                        FROM scan_issue si, issue i, scan s
                       WHERE si.issue_id = i.id
                         AND si.scan_id = p_scan_id
                         AND i.lastScan_id = s.id
                         AND i.scanStatus = 'REMOVED'
                         AND s.startDate < p_scanDate
                         AND si.projectVersion_id=p_projectVersion_id
                         AND si.engineType=ica.engineType
                         AND si.issueInstanceId=ica.issueInstanceId
                         AND NOT EXISTS (SELECT 1 FROM scan_issue_ca WHERE scan_id = si.scan_id AND issueInstanceId = si.issueInstanceId)
                     );

    UPDATE issue issue, scan_issue si, scan scan
    SET issue.lastScan_Id= si.scan_id, issue.removedDate=p_removedDate
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation
        , issue.friority=(case when p_customPriorityEnabled = 0 or issue.enginePriority is null then si.friority else issue.friority end)
        , issue.enginePriority=(case when p_customPriorityEnabled = 0 or issue.enginePriority is null then null else si.friority end)
        , issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        , issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
        , issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
        , issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        , issue.minVirtualCallConfidence=si.minVirtualCallConfidence
    WHERE issue.projectVersion_id = p_projectVersion_id
        AND issue.engineType = p_engineType
        AND si.scan_id = p_scan_id
        AND si.issueInstanceId = issue.issueInstanceId
        AND issue.scanStatus = 'REMOVED'
        AND issue.lastScan_id = scan.id
        AND scan.startDate < p_scanDate;
END//
DELIMITER ;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('updateRemovedWithUpload_mysql', 'hp', 'procs/dbF360_updateRemovedWithUpload.xml', NOW(), 749, '8:9dcc01ba111203e8fa9241f57792cbf4', 'sql; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset procs/dbF360_updateRemovedWithUpload2nd.xml::updateRemovedWithUpload2nd_mysql::hp
DROP PROCEDURE IF EXISTS updateRemovedWithUpload2nd;

DELIMITER //
CREATE PROCEDURE updateRemovedWithUpload2nd    (p_scan_id INT,
     p_projectVersion_Id INT,
     p_engineType varchar(20),
     p_scanDate BIGINT,
     p_removedDate BIGINT,
     p_customPriorityEnabled INT
    )
BEGIN
    UPDATE issue issue, scan_issue si, issue_ca ica, scan_issue_ca sica
    SET ica.engineType=sica.engineType, ica.dataVersion=sica.dataVersion, ica.metadataPluginId=sica.metadataPluginId,
	    ica.integerValue01 = sica.integerValue01, ica.integerValue02 = sica.integerValue02, ica.integerValue03 = sica.integerValue03,
	    ica.decimalValue01 = sica.decimalValue01, ica.decimalValue02 = sica.decimalValue02, ica.decimalValue03 = sica.decimalValue03, ica.decimalValue04 = sica.decimalValue04, ica.decimalValue05 = sica.decimalValue05,
	    ica.dateValue01 = sica.dateValue01, ica.dateValue02 = sica.dateValue02, ica.dateValue03 = sica.dateValue03, ica.dateValue04 = sica.dateValue04, ica.dateValue05 = sica.dateValue05,
	    ica.textValue01 = sica.textValue01, ica.textValue02 = sica.textValue02, ica.textValue03 = sica.textValue03, ica.textValue04 = sica.textValue04, ica.textValue05 = sica.textValue05,
	    ica.textValue06 = sica.textValue06, ica.textValue07 = sica.textValue07, ica.textValue08 = sica.textValue08, ica.textValue09 = sica.textValue09, ica.textValue10 = sica.textValue10,
	    ica.textValue11 = sica.textValue11, ica.textValue12 = sica.textValue12, ica.textValue13 = sica.textValue13, ica.textValue14 = sica.textValue14, ica.textValue15 = sica.textValue15, ica.textValue16 = sica.textValue16,
	    ica.clobValue01 = sica.clobValue01, ica.clobValue02 = sica.clobValue02, ica.clobValue03 = sica.clobValue03, ica.clobValue04 = sica.clobValue04, ica.clobValue05 = sica.clobValue05, ica.clobValue06 = sica.clobValue06
    WHERE issue.projectVersion_id = p_projectVersion_id
        AND issue.engineType = p_engineType
        AND si.scan_id = p_scan_id
        AND si.issue_id = issue.id
        AND issue.scanStatus = 'REMOVED'
        AND sica.issueInstanceId = si.issueInstanceId
        AND sica.scan_id = si.scan_id
        AND ica.issue_id = issue.id;

    INSERT into issue_ca (issue_id, projectVersion_id, issueInstanceId, engineType, dataVersion, metadataPluginId,
			integerValue01, integerValue02, integerValue03, decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
			dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
			textValue01, textValue02, textValue03, textValue04, textValue05, textValue06, textValue07, textValue08, textValue09, textValue10, textValue11, textValue12, textValue13, textValue14, textValue15, textValue16,
			clobValue01, clobValue02, clobValue03, clobValue04, clobValue05, clobValue06)
	    SELECT i.id, sica.projectVersion_id, sica.issueInstanceId, sica.engineType, sica.dataVersion, sica.metadataPluginId,
			sica.integerValue01, sica.integerValue02, sica.integerValue03, sica.decimalValue01, sica.decimalValue02, sica.decimalValue03, sica.decimalValue04, sica.decimalValue05,
			sica.dateValue01, sica.dateValue02, sica.dateValue03, sica.dateValue04, sica.dateValue05,
			sica.textValue01, sica.textValue02, sica.textValue03, sica.textValue04, sica.textValue05, sica.textValue06, sica.textValue07, sica.textValue08, sica.textValue09, sica.textValue10, sica.textValue11, sica.textValue12, sica.textValue13, sica.textValue14, sica.textValue15, sica.textValue16,
			sica.clobValue01, sica.clobValue02, sica.clobValue03, sica.clobValue04, sica.clobValue05, sica.clobValue06
	    FROM scan_issue_ca sica
	    join scan_issue si ON sica.issueInstanceId=si.issueInstanceId AND sica.scan_id=si.scan_id
	    join issue i ON i.id = si.issue_id join scan s ON i.lastScan_id=s.id
	    WHERE i.projectVersion_id = p_projectVersion_id AND si.scan_id = p_scan_id
	        AND NOT EXISTS (SELECT 1 FROM issue_ca ica WHERE ica.issue_id = i.id) AND i.scanStatus = 'REMOVED'
	        AND i.engineType = p_engineType;

    DELETE ica FROM issue_ca ica
        WHERE ica.projectVersion_id = p_projectVersion_id
        AND EXISTS (SELECT 1
                      from scan_issue si, issue i
                     WHERE si.issue_id = i.id
                       AND si.scan_id = p_scan_id
                       AND i.scanStatus = 'REMOVED'
                       AND si.projectVersion_id=p_projectVersion_id
                       AND si.engineType=ica.engineType
                       AND si.issueInstanceId=ica.issueInstanceId
                       AND NOT EXISTS (SELECT 1 FROM scan_issue_ca WHERE issueInstanceId = si.issueInstanceId AND scan_id = si.scan_id));


    UPDATE issue issue, scan_issue si
    SET issue.lastScan_Id= si.scan_id, issue.removedDate=p_removedDate
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation
        , issue.friority=(case when p_customPriorityEnabled = 0 or issue.enginePriority is null then si.friority else issue.friority end)
        , issue.enginePriority=(case when p_customPriorityEnabled = 0 or issue.enginePriority is null then null else si.friority end)
        , issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        , issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
        , issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
        , issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        , issue.minVirtualCallConfidence=si.minVirtualCallConfidence
    WHERE issue.projectVersion_id = p_projectVersion_id
        AND issue.engineType = p_engineType
        AND si.scan_id = p_scan_id
        AND si.issue_id = issue.id
        AND issue.scanStatus = 'REMOVED';
END//
DELIMITER ;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('updateRemovedWithUpload2nd_mysql', 'hp', 'procs/dbF360_updateRemovedWithUpload2nd.xml', NOW(), 751, '8:e69c275565908e2a55981f8e74ffc237', 'sql; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

--  Changeset procs/dbF360_extractFileName.xml::extractFileName_mysql::hp_main
DROP FUNCTION IF EXISTS extractFileName;

DELIMITER //
CREATE FUNCTION extractFileName(fullFilePath VARCHAR(3000)) RETURNS VARCHAR(500)    DETERMINISTIC
BEGIN
    DECLARE reversed varchar(3000);
    DECLARE result varchar(1000);
    declare slashPosition int;

    SET reversed = reverse(fullFilePath);
    SET slashPosition = LOCATE('/', reversed) - 1;
    IF slashPosition <= 0 THEN
		SET slashPosition = LOCATE('\\', reversed) - 1;
		IF slashPosition <= 0 THEN
			SET slashPosition = length(reversed);
		END IF;
    END IF;
    SET result = substr(reversed, 1, slashPosition);

    RETURN reverse(result);
END//
DELIMITER ;

INSERT INTO DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('extractFileName_mysql', 'hp_main', 'procs/dbF360_extractFileName.xml', NOW(), 753, '8:8ce26b442a3feef09c640621e71f2490', 'sql; sql', '', 'EXECUTED', NULL, NULL, '3.8.0', '2357944335');

