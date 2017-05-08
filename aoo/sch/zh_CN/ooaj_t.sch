/* 
================================================================================
檔案代號:ooaj_t
檔案名稱:使用幣別設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooaj_t
(
ooajent       number(5)      ,/* 企業編號 */
ooajownid       varchar2(20)      ,/* 資料所有者 */
ooajowndp       varchar2(10)      ,/* 資料所屬部門 */
ooajcrtid       varchar2(20)      ,/* 資料建立者 */
ooajcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooajcrtdt       timestamp(0)      ,/* 資料創建日 */
ooajmodid       varchar2(20)      ,/* 資料修改者 */
ooajmoddt       timestamp(0)      ,/* 最近修改日 */
ooajstus       varchar2(10)      ,/* 狀態碼 */
ooaj001       varchar2(5)      ,/* 幣別參照表號 */
ooaj002       varchar2(10)      ,/* 使用幣別 */
ooaj003       number(10,0)      ,/* 單價小數位數 */
ooaj004       number(10,0)      ,/* 金額小數位數 */
ooaj005       number(10,0)      ,/* 匯率計算精度 */
ooajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooajud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
ooaj006       number(10,0)      ,/* 成本單價小數位數 */
ooaj007       number(10,0)      /* 成本金額小數位數 */
);
alter table ooaj_t add constraint ooaj_pk primary key (ooajent,ooaj001,ooaj002) enable validate;

create unique index ooaj_pk on ooaj_t (ooajent,ooaj001,ooaj002);

grant select on ooaj_t to tiptop;
grant update on ooaj_t to tiptop;
grant delete on ooaj_t to tiptop;
grant insert on ooaj_t to tiptop;

exit;
