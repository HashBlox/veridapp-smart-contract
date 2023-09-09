// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract AttestationTemplateRegistry {
    struct AttestationTemplate {
        string templateName;
        string description;
        address organization;
        uint256 createdTimestamp;
        // You can define more fields here depending on your needs.
    }

    // Mapping from template ID to the template details
    mapping(uint256 => AttestationTemplate) public templates;

    // Counter for generating unique template IDs
    uint256 public templateCounter;

    // Event to log template creation
    event TemplateCreated(
        uint256 indexed templateId,
        string templateName,
        address indexed organization
    );

    // Function to create a new attestation template
    function createAttestationTemplate(string memory _templateName, string memory _description)
        external
    {
        uint256 templateId = templateCounter + 1;
        AttestationTemplate memory newTemplate = AttestationTemplate(
            _templateName,
            _description,
            msg.sender,
            block.timestamp
        );

        templates[templateId] = newTemplate;
        templateCounter = templateId;

        emit TemplateCreated(templateId, _templateName, msg.sender);
    }

    // Function to get the details of a specific template
    function getTemplateDetails(uint256 templateId)
        external
        view
        returns (
            string memory,
            string memory,
            address,
            uint256
        )
    {
        AttestationTemplate memory template = templates[templateId];
        return (
            template.templateName,
            template.description,
            template.organization,
            template.createdTimestamp
        );
    }
}
