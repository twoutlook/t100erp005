/* 
================================================================================
檔案代號:pcaa_t
檔案名稱:收銀機基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table pcaa_t
(
pcaaent       number(5)      ,/* 企業編號 */
pcaasite       varchar2(10)      ,/* 營運據點 */
pcaaunit       varchar2(10)      ,/* 應用組織 */
pcaa001       varchar2(10)      ,/* 收銀機編號 */
pcaaownid       varchar2(20)      ,/* 資料所有者 */
pcaaowndp       varchar2(10)      ,/* 資料所屬部門 */
pcaacrtid       varchar2(20)      ,/* 資料建立者 */
pcaacrtdp       varchar2(10)      ,/* 資料建立部門 */
pcaacrtdt       timestamp(0)      ,/* 資料創建日 */
pcaamodid       varchar2(20)      ,/* 資料修改者 */
pcaamoddt       timestamp(0)      ,/* 最近修改日 */
pcaastus       varchar2(10)      ,/* 狀態碼 */
pcaastamp       timestamp(5)      ,/* 時間戳記 */
pcaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcaa_t add constraint pcaa_pk primary key (pcaaent,pcaasite,pcaa001) enable validate;

create unique index pcaa_pk on pcaa_t (pcaaent,pcaasite,pcaa001);

grant select on pcaa_t to tiptop;
grant update on pcaa_t to tiptop;
grant delete on pcaa_t to tiptop;
grant insert on pcaa_t to tiptop;

exit;
