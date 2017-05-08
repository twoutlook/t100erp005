/* 
================================================================================
檔案代號:xmia_t
檔案名稱:銷售預測編號設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmia_t
(
xmiaent       number(5)      ,/* 企業編號 */
xmiaownid       varchar2(20)      ,/* 資料所有者 */
xmiaowndp       varchar2(10)      ,/* 資料所屬部門 */
xmiacrtid       varchar2(20)      ,/* 資料建立者 */
xmiacrtdp       varchar2(10)      ,/* 資料建立部門 */
xmiacrtdt       timestamp(0)      ,/* 資料創建日 */
xmiamodid       varchar2(20)      ,/* 資料修改者 */
xmiamoddt       timestamp(0)      ,/* 最近修改日 */
xmiastus       varchar2(10)      ,/* 狀態碼 */
xmia001       varchar2(10)      ,/* 預測編號 */
xmia002       number(5,0)      ,/* 預測期數 */
xmia003       number(5,0)      ,/* 預測起始日 */
xmia004       varchar2(10)      ,/* 預測幣別 */
xmia005       varchar2(10)      ,/* 匯率參照表號 */
xmia006       varchar2(10)      ,/* 匯率取得方式 */
xmia007       varchar2(10)      ,/* 匯率日期 */
xmia008       varchar2(10)      ,/* 取價方式 */
xmia009       varchar2(1)      ,/* 集團預測 */
xmia010       varchar2(1)      ,/* 預測方式-營運據點 */
xmia011       varchar2(1)      ,/* 預測方式-組織 */
xmia012       varchar2(1)      ,/* 預測方式-業務員 */
xmia013       varchar2(1)      ,/* 預測方式-客戶 */
xmia014       varchar2(1)      ,/* 預測方式-通路 */
xmia015       varchar2(1)      ,/* 預測方式-產品特徵 */
xmia016       varchar2(10)      ,/* 預測起始日指定方式 */
xmiaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmiaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmiaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmiaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmiaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmiaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmiaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmiaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmiaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmiaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmiaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmiaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmiaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmiaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmiaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmiaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmiaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmiaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmiaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmiaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmiaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmiaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmiaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmiaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmiaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmiaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmiaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmiaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmiaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmiaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmia_t add constraint xmia_pk primary key (xmiaent,xmia001) enable validate;

create unique index xmia_pk on xmia_t (xmiaent,xmia001);

grant select on xmia_t to tiptop;
grant update on xmia_t to tiptop;
grant delete on xmia_t to tiptop;
grant insert on xmia_t to tiptop;

exit;
