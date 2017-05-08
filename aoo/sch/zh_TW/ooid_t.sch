/* 
================================================================================
檔案代號:ooid_t
檔案名稱:繳款優惠條件設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooid_t
(
ooident       number(5)      ,/* 企業編號 */
ooidownid       varchar2(20)      ,/* 資料所有者 */
ooidowndp       varchar2(10)      ,/* 資料所屬部門 */
ooidcrtid       varchar2(20)      ,/* 資料建立者 */
ooidcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooidcrtdt       timestamp(0)      ,/* 資料創建日 */
ooidmodid       varchar2(20)      ,/* 資料修改者 */
ooidmoddt       timestamp(0)      ,/* 最近修改日 */
ooidstus       varchar2(10)      ,/* 狀態碼 */
ooid001       varchar2(10)      ,/* 優惠條件編號 */
ooid002       varchar2(1)      ,/* 適用類型（應收／應付） */
ooid003       varchar2(255)      ,/* 短備註說明 */
ooid011       number(5,0)      ,/* 提前收款天數以上(1) */
ooid012       number(20,6)      ,/* 折扣利率(1) */
ooid021       number(5,0)      ,/* 提前收款天數以上(2) */
ooid022       number(20,6)      ,/* 折扣利率(2) */
ooid031       number(5,0)      ,/* 提前收款天數以上(3) */
ooid032       number(20,6)      ,/* 折扣利率(3) */
ooidud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooidud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooidud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooidud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooidud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooidud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooidud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooidud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooidud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooidud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooidud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooidud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooidud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooidud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooidud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooidud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooidud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooidud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooidud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooidud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooidud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooidud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooidud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooidud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooidud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooidud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooidud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooidud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooidud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooidud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooid_t add constraint ooid_pk primary key (ooident,ooid001) enable validate;

create unique index ooid_pk on ooid_t (ooident,ooid001);

grant select on ooid_t to tiptop;
grant update on ooid_t to tiptop;
grant delete on ooid_t to tiptop;
grant insert on ooid_t to tiptop;

exit;
