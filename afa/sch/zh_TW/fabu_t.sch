/* 
================================================================================
檔案代號:fabu_t
檔案名稱:資產調撥單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabu_t
(
fabuent       number(5)      ,/* 企業編碼 */
fabuld       varchar2(10)      ,/* 帳套 */
fabudocno       varchar2(20)      ,/* 異動單號 */
fabuseq       number(10,0)      ,/* 項次 */
fabu000       number(10)      ,/* 異動類型 */
fabu001       varchar2(20)      ,/* 財產編號 */
fabu002       varchar2(20)      ,/* 附號 */
fabu003       varchar2(10)      ,/* 卡片編號 */
fabu004       number(20,6)      ,/* 未折減額 */
fabu005       varchar2(10)      ,/* 單位 */
fabu006       number(20,6)      ,/* 單價 */
fabu007       number(10,0)      ,/* 調撥/出售數量 */
fabu008       number(20,6)      ,/* 成本 */
fabu009       varchar2(10)      ,/* 稅種 */
fabu010       varchar2(10)      ,/* 交易幣種 */
fabu011       number(20,10)      ,/* 原幣匯率 */
fabu012       number(20,6)      ,/* 原幣稅前金額 */
fabu013       number(20,6)      ,/* 原幣稅額 */
fabu014       number(20,6)      ,/* 原幣應收金額 */
fabu015       number(20,6)      ,/* 本幣稅前金額 */
fabu016       number(20,6)      ,/* 本幣稅額 */
fabu017       number(20,6)      ,/* 本幣應收金額 */
fabu018       varchar2(24)      ,/* no use */
fabu019       varchar2(24)      ,/* 累折科目 */
fabu020       varchar2(24)      ,/* 減值準備科目 */
fabu021       varchar2(24)      ,/* 資產科目 */
fabu022       varchar2(24)      ,/* 應付帳款科目 */
fabu023       varchar2(24)      ,/* 稅額科目 */
fabu024       varchar2(10)      ,/* 營運據點 */
fabu025       varchar2(10)      ,/* 部門 */
fabu026       varchar2(10)      ,/* 利潤/成本中心 */
fabu027       varchar2(10)      ,/* 區域 */
fabu028       varchar2(10)      ,/* 交易客商 */
fabu029       varchar2(10)      ,/* 帳款客商 */
fabu030       varchar2(10)      ,/* 客群 */
fabu031       varchar2(20)      ,/* 人員 */
fabu032       varchar2(20)      ,/* 專案編號 */
fabu033       varchar2(30)      ,/* WBS */
fabu034       varchar2(20)      ,/* 帳款編號 */
fabu035       varchar2(40)      ,/* 摘要 */
fabu036       varchar2(20)      ,/* 應付帳款單號 */
fabu101       varchar2(10)      ,/* 本位幣二幣別 */
fabu102       number(20,10)      ,/* 本位幣二匯率 */
fabu103       number(20,6)      ,/* 本位幣二稅前金額 */
fabu104       number(20,6)      ,/* 本位幣二稅額 */
fabu105       number(20,6)      ,/* 本位幣二應付金額 */
fabu106       number(20,6)      ,/* 本位幣二處置成本 */
fabu107       number(20,6)      ,/* 本位幣二處置後未折減額 */
fabu150       number(20,6)      ,/* 本位幣三幣別 */
fabu151       number(20,6)      ,/* 本位幣三匯率 */
fabu152       number(20,6)      ,/* 本位幣三稅前金額 */
fabu153       number(20,6)      ,/* 本位幣三稅額 */
fabu154       number(20,6)      ,/* 本位幣三應付金額 */
fabu155       number(20,6)      ,/* 本位幣三處置成本 */
fabu156       number(20,6)      ,/* 本位幣三處置後未折減額 */
fabuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabuud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fabu_t add constraint fabu_pk primary key (fabuent,fabuld,fabudocno,fabuseq) enable validate;

create unique index fabu_pk on fabu_t (fabuent,fabuld,fabudocno,fabuseq);

grant select on fabu_t to tiptop;
grant update on fabu_t to tiptop;
grant delete on fabu_t to tiptop;
grant insert on fabu_t to tiptop;

exit;
