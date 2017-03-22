/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000000118342636_3842173357_init();
    work_m_00000000002636533929_4122600708_init();
    work_m_00000000001733448886_3190593924_init();
    work_m_00000000002070545113_3566469229_init();
    work_m_00000000003720667899_2598394010_init();
    work_m_00000000001965876978_2725559894_init();
    work_m_00000000002483670131_1949178628_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002483670131_1949178628");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}