/* 
================================================================================
檔案代號:pscd_t
檔案名稱:APS版本供需範圍庫位檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pscd_t
(
pscdent       number(5)      ,/* 企業編號 */
pscdsite       varchar2(10)      ,/* 營運據點 */
pscd001       varchar2(10)      ,/* APS版本 */
pscd002       varchar2(10)      ,/* 庫位 */
pscdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pscdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pscdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pscdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pscdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pscdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pscdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pscdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pscdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pscdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pscdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pscdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pscdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pscdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pscdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pscdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pscdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pscdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pscdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pscdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pscdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pscdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pscdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pscdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pscdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pscdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pscdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pscdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pscdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pscdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pscd_t add constraint pscd_pk primary key (pscdent,pscdsite,pscd001,pscd002) enable validate;

create unique index pscd_pk on pscd_t (pscdent,pscdsite,pscd001,pscd002);

grant select on pscd_t to tiptop;
grant update on pscd_t to tiptop;
grant delete on pscd_t to tiptop;
grant insert on pscd_t to tiptop;

exit;
