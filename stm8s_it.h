/**
  ******************************************************************************
  * @file     stm8s_it.h
  * @author   MCD Application Team
  * @version  V2.2.0
  * @date     30-September-2014
  * @brief    This file contains the headers of the interrupt handlers
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */ 

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM8S_IT_H
#define __STM8S_IT_H

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
#ifdef _COSMIC_
 void _stext(void); /* RESET startup routine */
 INTERRUPT void NonHandledInterrupt(void) __INTERRUPT(25);
#endif /* _COSMIC_ */

#ifndef _RAISONANCE_
 INTERRUPT void TRAP_IRQHandler(void) __TRAP; /* TRAP */
 INTERRUPT void TLI_IRQHandler(void) __INTERRUPT(0); /* TLI */
 INTERRUPT void AWU_IRQHandler(void) __INTERRUPT(1); /* AWU */
 INTERRUPT void CLK_IRQHandler(void) __INTERRUPT(2); /* CLOCK */
 INTERRUPT void EXTI_PORTA_IRQHandler(void) __INTERRUPT(3); /* EXTI PORTA */
 INTERRUPT void EXTI_PORTB_IRQHandler(void) __INTERRUPT(4); /* EXTI PORTB */
 INTERRUPT void EXTI_PORTC_IRQHandler(void) __INTERRUPT(5); /* EXTI PORTC */
 INTERRUPT void EXTI_PORTD_IRQHandler(void) __INTERRUPT(6); /* EXTI PORTD */
 INTERRUPT void EXTI_PORTE_IRQHandler(void) __INTERRUPT(7); /* EXTI PORTE */

#ifdef STM8S903
 INTERRUPT void EXTI_PORTF_IRQHandler(void) __INTERRUPT(8); /* EXTI PORTF */
#endif /*STM8S903*/

#if defined (STM8S208) || defined (STM8AF52Ax)
 INTERRUPT void CAN_RX_IRQHandler(void) __INTERRUPT(8); /* CAN RX */
 INTERRUPT void CAN_TX_IRQHandler(void) __INTERRUPT(9); /* CAN TX/ER/SC */
#endif /* STM8S208 || STM8AF52Ax */

 INTERRUPT void SPI_IRQHandler(void) __INTERRUPT(10); /* SPI */
 INTERRUPT void TIM1_CAP_COM_IRQHandler(void) __INTERRUPT(12); /* TIM1 CAP/COM */
 INTERRUPT void TIM1_UPD_OVF_TRG_BRK_IRQHandler(void) __INTERRUPT(11); /* TIM1 UPD/OVF/TRG/BRK */

#ifdef STM8S903
 INTERRUPT void TIM5_UPD_OVF_BRK_TRG_IRQHandler(void) __INTERRUPT(13); /* TIM5 UPD/OVF/BRK/TRG */
 INTERRUPT void TIM5_CAP_COM_IRQHandler(void) __INTERRUPT(14); /* TIM5 CAP/COM */
#else /*STM8S208, STM8S207, STM8S105 or STM8S103 or STM8AF52Ax or STM8AF62Ax or STM8A626x*/
 INTERRUPT void TIM2_UPD_OVF_BRK_IRQHandler(void) __INTERRUPT(13); /* TIM2 UPD/OVF/BRK */
 INTERRUPT void TIM2_CAP_COM_IRQHandler(void) __INTERRUPT(14); /* TIM2 CAP/COM */
#endif /*STM8S903*/

#if defined (STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8S105) || \
    defined(STM8S005) ||  defined (STM8AF52Ax) || defined (STM8AF62Ax) || defined (STM8AF626x)
 INTERRUPT void TIM3_UPD_OVF_BRK_IRQHandler(void) __INTERRUPT(15); /* TIM3 UPD/OVF/BRK */
 INTERRUPT void TIM3_CAP_COM_IRQHandler(void) __INTERRUPT(16); /* TIM3 CAP/COM */
#endif /*STM8S208, STM8S207 or STM8S105 or STM8AF52Ax or STM8AF62Ax or STM8A626x */

#if defined (STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8S103) || \
    defined(STM8S003) ||  defined (STM8AF52Ax) || defined (STM8AF62Ax) || defined (STM8S903)
 INTERRUPT void UART1_TX_IRQHandler(void) __INTERRUPT(17); /* UART1 TX */
 INTERRUPT void UART1_RX_IRQHandler(void) __INTERRUPT(18); /* UART1 RX */
#endif /*STM8S208, STM8S207, STM8S903 or STM8S103 or STM8AF52Ax or STM8AF62Ax */

 INTERRUPT void I2C_IRQHandler(void) __INTERRUPT(19); /* I2C */

#if defined(STM8S105) || defined(STM8S005) ||  defined (STM8AF626x)
 INTERRUPT void UART2_RX_IRQHandler(void) __INTERRUPT(21); /* UART2 RX */
 INTERRUPT void UART2_TX_IRQHandler(void) __INTERRUPT(20); /* UART2 TX */
#endif /* STM8S105 or STM8AF626x */

#if defined(STM8S207) || defined(STM8S007) || defined(STM8S208) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
 INTERRUPT void UART3_RX_IRQHandler(void) __INTERRUPT(21); /* UART3 RX */
 INTERRUPT void UART3_TX_IRQHandler(void) __INTERRUPT(20); /* UART3 TX */
#endif /*STM8S207, STM8S208, STM8AF62Ax or STM8AF52Ax */

#if defined(STM8S207) || defined(STM8S007) || defined(STM8S208) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
 INTERRUPT void ADC2_IRQHandler(void) __INTERRUPT(22); /* ADC2 */
#else /*STM8S105, STM8S103 or STM8S903*/
 INTERRUPT void ADC1_IRQHandler(void) __INTERRUPT(22); /* ADC1 */
#endif /*STM8S207, STM8S208, STM8AF62Ax or STM8AF52Ax */

#ifdef STM8S903
 INTERRUPT void TIM6_UPD_OVF_TRG_IRQHandler(void) __INTERRUPT(23); /* TIM6 UPD/OVF/TRG */
#else /*STM8S208, STM8S207, STM8S105 or STM8S103 or STM8AF62Ax or STM8AF52Ax or STM8AF626x */
 INTERRUPT void TIM4_UPD_OVF_IRQHandler(void) __INTERRUPT(23); /* TIM4 UPD/OVF */
#endif /*STM8S903*/
 INTERRUPT void EEPROM_EEC_IRQHandler(void) __INTERRUPT(24); /* EEPROM ECC CORRECTION */
#endif /* _RAISONANCE_ */

#endif /* __STM8S_IT_H */


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
