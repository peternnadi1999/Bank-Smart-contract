// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Bank{
        struct User{
            string fullname;
            uint balance;
            address accountNumber;
        }


        mapping(address => User) public Users;
       

        receive() external payable { }

       
         event DepositLog(address addre, uint amount);
         event WithdrawLog(address addre, uint amount);
         event createLog(address addre, string name, uint amount);

        function createAcc( string memory _fullname ) public {
            require(Users[msg.sender].accountNumber == address(0) , "Account already exist");
                Users[msg.sender] = User(_fullname,  address(this).balance, msg.sender);
                emit createLog(msg.sender, _fullname, address(this).balance);
        }
 
        function deposit() public  payable {
            Users[msg.sender].balance +=  msg.value;
            emit DepositLog( msg.sender, msg.sender.balance);
        }

        function withdraw(uint _amount) public  {
            require(_amount < address(this).balance , "insufficient balance");
            payable (Users[msg.sender].accountNumber).transfer( _amount);
            emit  WithdrawLog(Users[msg.sender].accountNumber, _amount);
        }
        function Transfer(uint _amount, address _address) public payable  {
            require(_amount <= address(this).balance , "insufficient balance");
            require(_address != Users[msg.sender].accountNumber , "please input a deffrent address");
            Users[msg.sender].balance -= _amount;
            Users[_address].balance +=_amount;

            payable (Users[msg.sender].accountNumber).transfer( _amount);
            emit  WithdrawLog(Users[msg.sender].accountNumber, _amount);
        }

        function getUsers(address _address) public view returns(User memory){
            return Users[_address];
        }


}
