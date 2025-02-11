import unittest, nim_kyber

suite "Tests from the documentation":
    setup: 
        var test_k: Kyber = createRandomKyber()

    test "Creating a kyber object":
        # Creates a kyber object with random keys and public tables
        var k: Kyber = createRandomKyber()

        assert true

    test "Creating Kyber object from preset":
        # Create preset kyber object
        var k: Kyber;
        k.noiseSecret = test_k.noiseSecret; # Two 256-number lists with range -1 to 1
        k.signalSecret = test_k.signalSecret; # Two 256-number lists with range -1 to 1
        k.publicTable = test_k.publicTable; # Four 256-number lists with range -1665 to 1665
        k.publicKeys = generatePublicKey(test_k.publicTable, test_k.signalSecret, test_k.noiseSecret); # Generate public keys from noiseSecret, signalSecret and publicTable. Not recommended to predefine
        assert k.publicKeys == test_k.publicKeys;

    test "Create message-sending object":
        # Define known public table and keys
        let publicTable = test_k.publicTable # Machine A's k.publicTable
        let publicKeys = test_k.publicKeys; # Machine A's k.publicKeys

        # Create Kyber Message Sender object
        var ms: KyberSender = createMessageSender(publicTable, publicKeys);

        assert true;

    test "Encrypting lists":
        # Define known public table and keys
        let publicTable = test_k.publicTable # Machine A's k.publicTable
        let publicKeys = test_k.publicKeys; # Machine A's k.publicKeys

        # Create Kyber Message Sender object
        var ms: KyberSender = createMessageSender(publicTable, publicKeys);

        # Encrypt message
        var l: List;
        var m: Message = ms.sendMessage(l.fill(0)); # Sended message

        # Now, share "m" with Machine A, and there you can decrypt it
        assert true

    test "Decrypting lists":
        # Generate message
        let publicTable = test_k.publicTable
        let publicKeys = test_k.publicKeys;
        var ms: KyberSender = createMessageSender(publicTable, publicKeys);
        var l: List;
        var m: Message = ms.sendMessage(l.fill(0));

        # Decrypt message
        var decrypted: List = test_k.recieveMessage(m); # m is Machine B's sended message

        assert decrypted[0] == 0
        assert decrypted[1] == 0
        assert decrypted[2] == 0
        assert decrypted[3] == 0
        assert decrypted[4] == 0
        assert decrypted[5] == 0
        assert decrypted[6] == 0
        assert decrypted[7] == 0

    test "Encrypting strings":
        # Define known public table and keys
        let publicTable = test_k.publicTable # Machine A's k.publicTable
        let publicKeys = test_k.publicKeys; # Machine A's k.publicKeys

        # Create Kyber Message Sender object
        var ms: KyberSender = createMessageSender(publicTable, publicKeys);

        # Encrypt message
        var m: Message = ms.sendString("Hello"); # Sended message

        # Now, share "m" with Machine A, and there you can decrypt it
        assert true

    test "Decrypting strings":
        let publicTable = test_k.publicTable # Machine A's k.publicTable
        let publicKeys = test_k.publicKeys; # Machine A's k.publicKeys
        var ms: KyberSender = createMessageSender(publicTable, publicKeys);
        var m: Message = ms.sendString("Hello"); # Sended message

        # Decrypt string
        var decrypted: string = test_k.recieveString(m); # m is Machine B's sended message

        assert decrypted == "Hello" # Original string