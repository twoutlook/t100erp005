/* 
================================================================================
檔案代號:ooha_t
檔案名稱:控制組主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooha_t
(
oohaent       number(5)      ,/* 企業編號 */
oohastus       varchar2(10)      ,/* 狀態碼 */
ooha001       varchar2(10)      ,/* 控制組編號 */
ooha002       varchar2(10)      ,/* 控制組類型 */
oohaownid       varchar2(20)      ,/* 資料所有者 */
oohaowndp       varchar2(10)      ,/* 資料所屬部門 */
oohacrtid       varchar2(20)      ,/* 資料建立者 */
oohacrtdp       varchar2(10)      ,/* 資料建立部門 */
oohacrtdt       timestamp(0)      ,/* 資料創建日 */
oohamodid       varchar2(20)      ,/* 資料修改者 */
oohamoddt       timestamp(0)      ,/* 最近修改日 */
oohaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oohaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oohaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oohaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oohaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oohaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oohaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oohaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oohaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oohaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oohaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oohaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oohaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oohaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oohaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oohaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oohaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oohaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oohaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oohaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oohaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oohaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oohaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oohaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oohaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oohaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oohaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oohaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oohaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oohaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooha_t add constraint ooha_pk primary key (oohaent,ooha001) enable validate;

create unique index ooha_pk on ooha_t (oohaent,ooha001);

grant select on ooha_t to tiptop;
grant update on ooha_t to tiptop;
grant delete on ooha_t to tiptop;
grant insert on ooha_t to tiptop;

exit;
