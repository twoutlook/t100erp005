/* 
================================================================================
檔案代號:sraa_t
檔案名稱:重覆性生產計畫單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table sraa_t
(
sraaent       number(5)      ,/* 企業編號 */
sraasite       varchar2(10)      ,/* 營運據點 */
sraaownid       varchar2(20)      ,/* 資料所有者 */
sraaowndp       varchar2(10)      ,/* 資料所屬部門 */
sraacrtid       varchar2(20)      ,/* 資料建立者 */
sraacrtdp       varchar2(10)      ,/* 資料建立部門 */
sraacrtdt       timestamp(0)      ,/* 資料創建日 */
sraamodid       varchar2(20)      ,/* 資料修改者 */
sraamoddt       timestamp(0)      ,/* 最近修改日 */
sraacnfid       varchar2(20)      ,/* 資料確認者 */
sraacnfdt       timestamp(0)      ,/* 資料確認日 */
sraastus       varchar2(10)      ,/* 狀態碼 */
sraa000       number(10,0)      ,/* 版本 */
sraa001       varchar2(10)      ,/* 生產計畫 */
sraa002       number(5,0)      ,/* 年 */
sraa003       number(5,0)      ,/* 月 */
sraaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sraaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sraaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sraaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sraaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sraaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sraaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sraaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sraaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sraaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sraaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sraaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sraaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sraaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sraaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sraaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sraaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sraaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sraaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sraaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sraaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sraaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sraaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sraaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sraaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sraaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sraaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sraaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sraaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sraaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sraa_t add constraint sraa_pk primary key (sraaent,sraasite,sraa000,sraa001,sraa002,sraa003) enable validate;

create unique index sraa_pk on sraa_t (sraaent,sraasite,sraa000,sraa001,sraa002,sraa003);

grant select on sraa_t to tiptop;
grant update on sraa_t to tiptop;
grant delete on sraa_t to tiptop;
grant insert on sraa_t to tiptop;

exit;
