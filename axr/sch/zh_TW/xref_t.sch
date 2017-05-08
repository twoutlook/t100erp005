/* 
================================================================================
檔案代號:xref_t
檔案名稱:月結主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xref_t
(
xrefent       number(5)      ,/* 企業代碼 */
xrefcomp       varchar2(10)      ,/* 法人 */
xrefsite       varchar2(10)      ,/* 帳務組織 */
xrefld       varchar2(5)      ,/* 帳別 */
xref001       number(5,0)      ,/* 年度 */
xref002       number(5,0)      ,/* 期別 */
xref003       varchar2(10)      ,/* 來源模組 */
xreforga       varchar2(10)      ,/* 來源組織 */
xref004       varchar2(10)      ,/* 帳款單性質 */
xref005       varchar2(20)      ,/* 單據號碼 */
xref006       number(10,0)      ,/* 項次 */
xref007       number(5,0)      ,/* 分期帳款序 */
xref008       date      ,/* 立帳日期 */
xref009       varchar2(10)      ,/* 帳款對象 */
xref010       varchar2(10)      ,/* 收款對象 */
xref011       varchar2(24)      ,/* 應收科目 */
xref012       varchar2(24)      ,/* 收入科目 */
xref013       varchar2(20)      ,/* 暫估月結傳票 */
xref014       varchar2(20)      ,/* 暫估回轉傳票 */
xref100       varchar2(10)      ,/* 幣別 */
xref101       number(20,10)      ,/* 暫估匯率 */
xref103       number(20,6)      ,/* 暫估單未沖原幣金額 */
xref113       number(20,6)      ,/* 暫估單未沖本幣金額 */
xref123       number(20,6)      ,/* 暫估單本位幣二未沖金額 */
xref133       number(20,6)      ,/* 暫估單本位幣三未沖金額 */
xrefud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrefud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrefud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrefud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrefud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrefud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrefud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrefud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrefud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrefud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrefud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrefud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrefud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrefud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrefud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrefud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrefud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrefud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrefud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrefud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrefud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrefud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrefud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrefud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrefud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrefud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrefud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrefud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrefud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrefud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xref_t add constraint xref_pk primary key (xrefent,xref001,xref002,xref003,xref005,xref006,xref007) enable validate;

create unique index xref_pk on xref_t (xrefent,xref001,xref002,xref003,xref005,xref006,xref007);

grant select on xref_t to tiptop;
grant update on xref_t to tiptop;
grant delete on xref_t to tiptop;
grant insert on xref_t to tiptop;

exit;
