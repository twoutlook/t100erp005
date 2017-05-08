/*
================================================================================
檔案代號:aaga_t
檔案名稱:會計科目名稱檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
*/
create table aaga_t
(
aaga000      varchar2(5) NOT NULL,    /*帳別                                   */
aaga010      varchar2(24) NOT NULL,   /*科目編號                               */
aaga020      varchar2(120) DEFAULT ' ', /*科目名稱*/
aaga030      varchar2(1),             /*科目性質                               */
                                      /*科目性質 (2.帳戶 4.結轉)               */
aaga040      varchar2(1),             /*資產損益別                             */
                                      /*資產損益別 (1.資產負債/2.損益)         */
aaga050      varchar2(1),             /*本科目是否作部門明細管理               */
                                      /*本科目是否作部門明細管理(Y/N)          */
aaga060      varchar2(1),             /*正常餘額型態                           */
                                      /*正常餘額型態 (1.借餘/2.貸餘)           */
aaga070      varchar2(1),             /*統制明細別                             */
                                      /*(1.統制帳戶2.明細帳戶3.獨立帳戶)       */
aaga080      varchar2(24),            /*所屬統制帳戶科目                       */
aaga090      varchar2(1),             /*是否為貨幣性科目                       */
                                      /*是否為貨幣性科目(Y/N)                  */
aaga100      varchar2(10),            /*No Use                                 */
aaga110      varchar2(4),             /*No Use                                 */
aaga120      varchar2(4),             /*計數單位                               */
aaga130      varchar2(120),           /*額外名稱                               */
aaga140      varchar2(255),           /*備註                                   */
aaga150      varchar2(10),            /*異動碼-1類型代號                       */
aaga151      varchar2(1),             /*異動碼-1控制方式                       */
aaga160      varchar2(10),            /*異動碼-2類型代號                       */
aaga161      varchar2(1),             /*異動碼-2控制方式                       */
aaga170      varchar2(10),            /*異動碼-3類型代號                       */
aaga171      varchar2(1),             /*異動碼-3控制方式                       */
aaga180      varchar2(10),            /*異動碼-4類型代號                       */
                                      /* NULL:不輸入                           */
                                      /*    1:可輸入,  可空白                  */
                                      /*    2.必須輸入,不需檢查                */
                                      /*    3.必須輸入, 必須檢查               */
aaga181      varchar2(1),             /*異動碼-4控制方式                       */
aaga190      number(5),               /*財務比率分析類別                       */
                                      /*財務比率分析類別(1-27)                 */
aaga200      varchar2(1),             /*細項立沖否                             */
                                      /*細項立沖否(Y/N)  (99-05-21 add)        */
aaga210      varchar2(1),             /*線上預算控制                           */
                                      /*是否作線上預算控制(Y/N)                */
aaga221      varchar2(5),             /*費用固定變動別                         */
                                      /*費用固定變動別(F/V) F:固定 V:變動      */
aaga222      varchar2(5),             /*傳票項次異動別                         */
                                      /*傳票項次異動別(1:借方立帳 2:貸方立帳)  */
aaga223      varchar2(10),            /*分類碼一                               */
aaga224      varchar2(10),            /*分類碼二                               */
aaga225      varchar2(10),            /*分類碼三                               */
aaga226      varchar2(10),            /*分類碼四                               */
aaga230      varchar2(1),             /*作專案管理                             */
                                      /*是否作專案管理(Y/N)                    */
aaga240      number(5),               /*科目層級                               */
                                      /*科目層級                     for 大陸版*/
aaga310      varchar2(10),            /*異動碼-5類型代號                       */
aaga311      varchar2(1),             /*異動碼-5輸入控制                       */
aaga320      varchar2(10),            /*異動碼-6類型代號                       */
aaga321      varchar2(1),             /*異動碼-6輸入控制                       */
aaga330      varchar2(10),            /*異動碼-7類型代號                       */
aaga331      varchar2(1),             /*異動碼-7輸入控制                       */
aaga340      varchar2(10),            /*異動碼-8類型代號                       */
aaga341      varchar2(1),             /*異動碼-8輸入控制                       */
aaga350      varchar2(10),            /*異動碼-9類型代號                       */
aaga351      varchar2(1),             /*異動碼-9輸入控制                       */
aaga360      varchar2(10),            /*異動碼-10類型代號                      */
aaga361      varchar2(1),             /*異動碼-10輸入控制                      */
aaga370      varchar2(10),            /*關係人異動碼類型代號                   */
aaga371      varchar2(1),             /*關係人異動碼輸入控制                   */
aaga380      varchar2(1),             /*是否為內部管理科目                     */
aaga390      varchar2(10) DEFAULT ' ' NOT NULL, /*資料來源*/
aaga400      number(10),              /*拋轉次數                               */
aaga410      varchar2(6),             /*現金變動碼                             */
aaga420      varchar2(1) DEFAULT 'N' NOT NULL, /*按餘額類型產生分錄*/
aagaacti     varchar2(1),             /*資料有效碼                             */
aagauser     varchar2(10),            /*資料所有者                             */
aagabuid     date,                    /*資料建立日                             */
aagadept     varchar2(10),            /*資料所有群                             */
aagaoriu     varchar2(10),            /*資料建立者                             */
aagaorid     varchar2(10),            /*資料建立部門                           */
aagamodu     varchar2(10),            /*資料更改者                             */
aagadate     date                     /*最近修改日                             */
);

create index aaga_02 on aaga_t (aaga080);
alter table aaga_t add constraint aaga_pk primary key (aaga000,aaga010) enable validate;
grant select on aaga_t to tiptopgp;
grant update on aaga_t to tiptopgp;
grant delete on aaga_t to tiptopgp;
grant insert on aaga_t to tiptopgp;
grant index on aaga_t to public;
grant select on aaga_t to ods;
