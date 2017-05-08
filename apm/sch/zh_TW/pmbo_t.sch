/* 
================================================================================
檔案代號:pmbo_t
檔案名稱:供應商評核公式評分等級明細檔(製造)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmbo_t
(
pmboent       number(5)      ,/* 企業編號 */
pmbosite       varchar2(10)      ,/* 營運據點 */
pmbo001       varchar2(10)      ,/* 公式編號 */
pmbo002       varchar2(10)      ,/* 評核等級 */
pmbo003       number(5,0)      ,/* 分數起 */
pmbo004       number(5,0)      ,/* 分數迄 */
pmboud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmboud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmboud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmboud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmboud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmboud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmboud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmboud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmboud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmboud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmboud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmboud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmboud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmboud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmboud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmboud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmboud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmboud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmboud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmboud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmboud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmboud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmboud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmboud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmboud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmboud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmboud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmboud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmboud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmboud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbo_t add constraint pmbo_pk primary key (pmboent,pmbosite,pmbo001,pmbo002) enable validate;

create unique index pmbo_pk on pmbo_t (pmboent,pmbosite,pmbo001,pmbo002);

grant select on pmbo_t to tiptop;
grant update on pmbo_t to tiptop;
grant delete on pmbo_t to tiptop;
grant insert on pmbo_t to tiptop;

exit;
