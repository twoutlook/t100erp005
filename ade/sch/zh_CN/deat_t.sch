/* 
================================================================================
檔案代號:deat_t
檔案名稱:POS读帐条
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table deat_t
(
deatent       number(5)      ,/* 企業編碼 */
deatdocno       varchar2(20)      ,/* 原始單號 */
deatsite       varchar2(10)      ,/* 門店編號 */
deat001       date      ,/* 營業日期 */
deat002       varchar2(10)      ,/* 收銀員編號 */
deat003       varchar2(10)      ,/* 款別編碼 */
deat004       varchar2(10)      ,/* 专柜编号 */
deat005       varchar2(10)      ,/* 班別 */
deat006       number(20,6)      ,/* 實收金額 */
deat007       number(20,6)      ,/* POS讀帳條（本地延遲上傳） */
deat008       number(20,6)      ,/* POS伺服器金額彙總 */
deat009       number(20,6)      ,/* 差異金額 */
deat010       varchar2(1)      ,/* 核對立帳否 */
deat011       date      ,/* 創建時間 */
deat012       varchar2(10)      ,/* 收銀機編號 */
deatud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deatud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deatud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deatud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deatud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deatud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deatud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deatud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deatud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deatud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deatud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deatud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deatud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deatud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deatud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deatud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deatud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deatud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deatud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deatud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deatud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deatud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deatud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deatud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deatud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deatud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deatud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deatud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deatud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deatud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deat_t add constraint deat_pk primary key (deatent,deatdocno,deatsite,deat001,deat002,deat003,deat004,deat005,deat012) enable validate;

create unique index deat_pk on deat_t (deatent,deatdocno,deatsite,deat001,deat002,deat003,deat004,deat005,deat012);

grant select on deat_t to tiptop;
grant update on deat_t to tiptop;
grant delete on deat_t to tiptop;
grant insert on deat_t to tiptop;

exit;
