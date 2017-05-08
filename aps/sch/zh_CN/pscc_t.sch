/* 
================================================================================
檔案代號:pscc_t
檔案名稱:APS版本供需範圍單別檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pscc_t
(
psccent       number(5)      ,/* 企業編號 */
psccsite       varchar2(10)      ,/* 營運據點 */
pscc001       varchar2(10)      ,/* APS版本 */
pscc002       varchar2(5)      ,/* 單據別 */
psccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pscc_t add constraint pscc_pk primary key (psccent,psccsite,pscc001,pscc002) enable validate;

create unique index pscc_pk on pscc_t (psccent,psccsite,pscc001,pscc002);

grant select on pscc_t to tiptop;
grant update on pscc_t to tiptop;
grant delete on pscc_t to tiptop;
grant insert on pscc_t to tiptop;

exit;
