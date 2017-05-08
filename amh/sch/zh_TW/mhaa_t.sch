/* 
================================================================================
檔案代號:mhaa_t
檔案名稱:樓棟基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table mhaa_t
(
mhaaent       number(5)      ,/* 企業編號 */
mhaasite       varchar2(10)      ,/* 營運據點 */
mhaaunit       varchar2(10)      ,/* 應用組織 */
mhaa001       varchar2(10)      ,/* 樓棟編號 */
mhaa002       number(20,6)      ,/* 建築面積 */
mhaa003       number(20,6)      ,/* 測量面積 */
mhaa004       number(20,6)      ,/* 經營面積 */
mhaa005       number(20,6)      ,/* 圖紙建築面積 */
mhaa006       number(20,6)      ,/* 圖紙測量面積 */
mhaaownid       varchar2(20)      ,/* 資料所有者 */
mhaaowndp       varchar2(10)      ,/* 資料所屬部門 */
mhaacrtid       varchar2(20)      ,/* 資料建立者 */
mhaacrtdp       varchar2(10)      ,/* 資料建立部門 */
mhaacrtdt       timestamp(0)      ,/* 資料創建日 */
mhaamodid       varchar2(20)      ,/* 資料修改者 */
mhaamoddt       timestamp(0)      ,/* 最近修改日 */
mhaastus       varchar2(10)      ,/* 狀態碼 */
mhaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mhaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mhaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mhaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mhaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mhaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mhaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mhaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mhaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mhaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mhaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mhaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mhaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mhaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mhaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mhaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mhaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mhaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mhaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mhaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mhaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mhaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mhaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mhaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mhaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mhaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mhaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mhaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mhaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mhaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mhaa_t add constraint mhaa_pk primary key (mhaaent,mhaasite,mhaa001) enable validate;

create unique index mhaa_pk on mhaa_t (mhaaent,mhaasite,mhaa001);

grant select on mhaa_t to tiptop;
grant update on mhaa_t to tiptop;
grant delete on mhaa_t to tiptop;
grant insert on mhaa_t to tiptop;

exit;
