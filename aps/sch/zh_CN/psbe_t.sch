/* 
================================================================================
檔案代號:psbe_t
檔案名稱:MDS計算策略自定時距檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psbe_t
(
psbeent       number(5)      ,/* 企業編號 */
psbe001       varchar2(10)      ,/* MDS編號 */
psbe002       number(5,0)      ,/* 時距 */
psbe003       varchar2(10)      ,/* 時距期間 */
psbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psbe_t add constraint psbe_pk primary key (psbeent,psbe001,psbe002) enable validate;

create unique index psbe_pk on psbe_t (psbeent,psbe001,psbe002);

grant select on psbe_t to tiptop;
grant update on psbe_t to tiptop;
grant delete on psbe_t to tiptop;
grant insert on psbe_t to tiptop;

exit;
