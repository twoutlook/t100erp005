/* 
================================================================================
檔案代號:inap_t
檔案名稱:庫存在揀量明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inap_t
(
inapent       number(5)      ,/* 企業編號 */
inapsite       varchar2(10)      ,/* 營運據點 */
inap001       varchar2(40)      ,/* 單據編號 */
inap002       varchar2(40)      ,/* 項次 */
inap003       varchar2(40)      ,/* 項序 */
inap004       varchar2(40)      ,/* 料件編號 */
inap005       varchar2(256)      ,/* 產品特徵 */
inap006       varchar2(30)      ,/* 庫存管理特徵 */
inap007       varchar2(10)      ,/* 庫位編號 */
inap008       varchar2(10)      ,/* 儲位編號 */
inap009       varchar2(30)      ,/* 批號 */
inap010       varchar2(10)      ,/* 交易單位 */
inap011       number(20,6)      ,/* 在揀量(交易單位) */
inap012       varchar2(10)      ,/* 庫存單位 */
inap013       number(20,6)      ,/* 在揀量(庫存單位) */
inap014       varchar2(10)      ,/* 異動命令 */
inap015       date      ,/* 單據日期 */
inap016       date      ,/* 揀貨日期 */
inap017       varchar2(20)      ,/* 申請人員 */
inap018       varchar2(10)      ,/* 申請部門 */
inapud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inapud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inapud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inapud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inapud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inapud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inapud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inapud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inapud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inapud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inapud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inapud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inapud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inapud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inapud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inapud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inapud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inapud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inapud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inapud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inapud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inapud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inapud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inapud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inapud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inapud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inapud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inapud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inapud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inapud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inap_t add constraint inap_pk primary key (inapent,inap001,inap002,inap003) enable validate;

create unique index inap_pk on inap_t (inapent,inap001,inap002,inap003);

grant select on inap_t to tiptop;
grant update on inap_t to tiptop;
grant delete on inap_t to tiptop;
grant insert on inap_t to tiptop;

exit;
