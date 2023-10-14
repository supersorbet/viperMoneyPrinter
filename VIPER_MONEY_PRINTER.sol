// SPDX-License-Identifier: Frensware 

   //auth Fronthand Backhand!!!!


import "./SafeMeth.sol";
import "./Adderall.sol";
import "./IERC20.sol";
import "./SafeERC20.sol";
import "./SafeERC20.sol";
import "./Pwnable.sol";
import "./UniV2Factory.sol";


pragma solidity ^0.8.17;



interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}



interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);
    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);
    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);
    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;
    function initialize(address, address) external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}


contract viperRapperMoneyPrinter is Ownable {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;
    using Address for address;

    address public topMalla;
    address WETH =  //0x21be370D5312f44cB42ce377BC9b8a0cEF1A4C83;//FTM
                    // 
                    0x471EcE3750Da237f93B8E339c536989b8978a438;//////// CELO
                    //0xcF664087a5bB0237a0BAd6742852ec6c8d69A27a;//ONE
                    //0x98878B06940aE243284CA214f92Bb71a2b032B8A;//MOVR

    mapping (uint256 => address) _stableYesNo;

    mapping (address => bool) _isRouter;
    mapping (address => string) _dexRouterName;
    mapping (string => dexRouterInfo) dexRouterData;
    address[] dexRouterInfo_dexRouterData;
    
    struct dexRouterInfo {
        string dexRouterName;
        address dexRouterAddress;
        address dexRouterContractAddy;
        address dexRouterFactory;
    }

    constructor() {
        topMalla = msg.sender;
    }

    //EXECUTABLE STUFF
    
    function stashCrackAddress(address dexRouter, string memory rName) public onlyOwner {
        dexRouterInfo storage info = dexRouterData[rName];
            info.dexRouterName = rName;
            info.dexRouterAddress = dexRouter;
            info.dexRouterContractAddy = dexRouter;
        address factory = IUniswapV2Router02(dexRouter).factory();
            info.dexRouterFactory = factory;
    }

        function fuckEarthImGoneWageAnInterstellarWar(//breakDance(
            address _dexRouter1, 
            address _dexRouter2,
            address music, 
            address dancePartner, 
            uint256 _amount, 
            uint256 decimals,
            bool takeStacks
                ) external onlyOwner {
            uint spotOne = IERC20(music).balanceOf(address(this));
            uint spotTwo = IERC20(dancePartner).balanceOf(address(this));
            uint256 val = _amount.mul(10 ** decimals);
            swingLow(_dexRouter1, music, dancePartner, val);

            uint spotTwoTwo = IERC20(dancePartner).balanceOf(address(this));
            uint swingVal = spotTwoTwo - spotTwo;
            swingLow(_dexRouter2, dancePartner, music, swingVal);

            uint spotOneTwo = IERC20(music).balanceOf(address(this));
            require(spotOneTwo >= spotOne, "Done messed up You Fuckin Idiot Bitch Im De-Throning Reptillian Pussy In my Sleep");

            if(takeStacks == true) {
                uint256 profit = spotOneTwo.sub(spotOne);
                IERC20(music).transfer(topMalla, profit);
            }
        }

        function putSomeRelishAndMustaOnItItAintExtra(//CompoundingYeets(
            address _dexRouter1,
            address _dexRouter2,
            address swinger
                ) public onlyOwner {
            uint256 spotOne = IERC20(WETH).balanceOf(address(this));
            uint256 spotTwo = IERC20(swinger).balanceOf(address(this));
            swingLow(_dexRouter1, WETH, swinger, spotOne);

            uint256 spotTwoTwo = IERC20(swinger).balanceOf(address(this));
            uint256 swingVal = spotTwoTwo.sub(spotTwo);
            swingLow(_dexRouter2, swinger, WETH, swingVal);

            uint256 spotOneTwo = IERC20(WETH).balanceOf(address(this));
            require(spotOneTwo >= spotOne, "Done messed up AyAyron");
        }

        function youllCowardsDontEvenSmokeCrack(//everybodyBreakdancebutWithTechno(
            string memory _dexRouter1, 
            string memory _dexRouter2, 
            address dancePartner, 
            uint256 _amount, 
            bool takeStacks
                ) external {
            dexRouterInfo memory info1 = dexRouterData[_dexRouter1];
                address rout1 = info1.dexRouterAddress;
            dexRouterInfo memory info2 = dexRouterData[_dexRouter2];
                address rout2 = info2.dexRouterAddress;

            uint256 spotOne = IERC20(WETH).balanceOf(address(this));
            uint256 spotTwo = IERC20(dancePartner).balanceOf(address(this));
            uint256 wVal = _amount.mul(10 ** 18);

            swingLow(rout1, WETH, dancePartner, wVal);

            uint spotTwoTwo = IERC20(dancePartner).balanceOf(address(this));
            uint tradeableAmount = spotTwoTwo - spotTwo;

            swingLow(rout2, dancePartner, WETH, tradeableAmount);

            uint endBalance = IERC20(WETH).balanceOf(address(this));
            require(endBalance > spotOne, "Trade Reverted, No Profit Made");

            if(takeStacks == true) {
                uint256 profit = endBalance.sub(spotOne);
                IERC20(WETH).transfer(topMalla, profit);
            }
        }

        function KillUrselfMyMan(//3 part(
            address _dexRouter1, 
            address _dexRouter2,
            address _dexRouter3,
            address music, 
            address cutIn,
            address dancePartner, 
            uint256 _amount, 
            uint256 decimals
                ) external onlyOwner {
            uint256 spotOne = IERC20(music).balanceOf(address(this));
            uint256 spotTwo = IERC20(cutIn).balanceOf(address(this));
            uint256 spotThree = IERC20(dancePartner).balanceOf(address(this));
            uint256 aVal = _amount.mul(10 ** decimals);
            swingLow(_dexRouter1, music, cutIn, aVal);

            uint256 spotTwoTwo = IERC20(cutIn).balanceOf(address(this));
            uint256 swingVal = spotTwoTwo.sub(spotTwo);
            swingLow(_dexRouter2, cutIn, dancePartner, swingVal);

            uint256 spotThreeTwo = IERC20(dancePartner).balanceOf(address(this));
            uint256 swingVal2 = spotThreeTwo.sub(spotThree);
            swingLow(_dexRouter3, dancePartner, music, swingVal2);

            uint endBalance = IERC20(music).balanceOf(address(this));
            require(endBalance > spotOne, "Crack Reverted, No Profit Made");
        }

        function DecapitateAPolice(//three Part Yeet()))))
            address _dexRouter1, 
            address _dexRouter2,
            address _dexRouter3,
            address cutIn,
            address dancePartner
                ) external onlyOwner {
            uint256 spotOne = IERC20(WETH).balanceOf(address(this));
            uint256 spotTwo = IERC20(cutIn).balanceOf(address(this));
            uint256 spotThree = IERC20(dancePartner).balanceOf(address(this));
            uint256 aVal = IERC20(WETH).balanceOf(address(this));
            swingLow(_dexRouter1, WETH, cutIn, aVal);

            uint256 spotTwoTwo = IERC20(cutIn).balanceOf(address(this));
            uint256 swingVal = spotTwoTwo.sub(spotTwo);
            swingLow(_dexRouter2, cutIn, dancePartner, swingVal);

            uint256 spotThreeTwo = IERC20(dancePartner).balanceOf(address(this));
            uint256 swingVal2 = spotThreeTwo.sub(spotThree);
            swingLow(_dexRouter3, dancePartner, WETH, swingVal2);

            uint endBalance = IERC20(WETH).balanceOf(address(this));
            require(endBalance > spotOne, "Trade Reverted, No Profit Made");
        }

        function gibsRocks() external onlyOwner {
            payable(msg.sender).transfer(address(this).balance);
        }

        function gibsTendies(address tendies) external onlyOwner {
            IERC20(tendies).transfer(
                msg.sender, 
                IERC20(tendies).balanceOf(address(this)));
        }


    // INTERNAL FUNCTIONS

        function swingLow(
            address dexRouter, 
            address _tokenIn, 
            address _tokenOut, 
            uint256 _amount
                ) internal {
                    if(IERC20(_tokenIn).allowance(address(this), dexRouter) < 1) {
                        uint256 aVal = IERC20(_tokenIn).totalSupply();
                        IERC20(_tokenIn).approve(dexRouter, aVal); }
            address[] memory path;
            path = new address[](2);
            path[0] = _tokenIn;
            path[1] = _tokenOut;
            //uint deadline = block.timestamp + 5;
            IUniswapV2Router02(dexRouter).swapExactTokensForTokens(
                _amount, 
                0, 
                path, 
                address(this), 
                block.timestamp);
        }

        function getAmountOutMin(address dexRouter, address _tokenIn, address _tokenOut, uint256 _amount) public view returns (uint256) {
            address[] memory path;
            path = new address[](2);
            path[0] = _tokenIn;
            path[1] = _tokenOut;
            uint256[] memory amountOutMins = IUniswapV2Router02(dexRouter).getAmountsOut(_amount, path);
            return amountOutMins[path.length -1];
        }

    // VIEW FUCKTIONS

        function estimateDualCrackTrade(
            address _dexRouter1, 
            address _dexRouter2, 
            address _token1, 
            address _token2, 
            uint256 _amount
                ) external view returns (uint256) {
            uint256 amtBack1 = getAmountOutMin(_dexRouter1, _token1, _token2, _amount);
            uint256 amtBack2 = getAmountOutMin(_dexRouter2, _token2, _token1, amtBack1);
                return amtBack2;
        }
                    
        function estimateTriDexTrade(
            address _dexRouter1, 
            address _dexRouter2, 
            address _dexRouter3, 
            address _token1, 
            address _token2, 
            address _token3, 
            uint256 _amount
                ) external view returns (uint256) {
            uint amtBack1 = getAmountOutMin(_dexRouter1, _token1, _token2, _amount);
            uint amtBack2 = getAmountOutMin(_dexRouter2, _token2, _token3, amtBack1);
            uint amtBack3 = getAmountOutMin(_dexRouter3, _token3, _token1, amtBack2);
            return amtBack3;
        }

}