  for(uint256 j; j < redTeam.length; ++j) {
                address winner = redTeam[j];
                assembly {

                    let location := winners
     
                    let length := mload(winners)
        
                    let nextMemoryLocation := add( location, mul( length, 0x20 ) )
                    let freeMem := mload(0x40)

                    let newMsize := add( freeMem, 0x20 )

                    if iszero( eq( freeMem, nextMemoryLocation) ){
                        let currVal
                        let prevVal
                    
                        for { let i := nextMemoryLocation } lt(i, newMsize) { i := add(i, 0x20) } {
                        
                            currVal := mload(i)
                            mstore(i, prevVal)
                            prevVal := currVal
                        
                        }
                    }
                    
                    mstore(nextMemoryLocation, winner)
        
                    length := add( length, 1 )

                    mstore(0x40, newMsize )
                }
            }
        }