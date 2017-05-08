/* 
================================================================================
檔案代號:imea_t
檔案名稱:料件特徵群組單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imea_t
(
imeaent       number(5)      ,/* 企業編號 */
imeaownid       varchar2(20)      ,/* 資料所有者 */
imeaowndp       varchar2(10)      ,/* 資料所屬部門 */
imeacrtid       varchar2(20)      ,/* 資料建立者 */
imeacrtdp       varchar2(10)      ,/* 資料建立部門 */
imeacrtdt       timestamp(0)      ,/* 資料創建日 */
imeamodid       varchar2(20)      ,/* 資料修改者 */
imeamoddt       timestamp(0)      ,/* 最近修改日 */
imeastus       varchar2(10)      ,/* 狀態碼 */
imea001       varchar2(40)      ,/* 特徵群組代碼 */
imea002       varchar2(1)      ,/* 庫存系統記錄產品特徵值 */
imea003       varchar2(1)      ,/* 需求單據是否需指定產品特徵 */
imeaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imeaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imeaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imeaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imeaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imeaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imeaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imeaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imeaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imeaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imeaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imeaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imeaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imeaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imeaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imeaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imeaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imeaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imeaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imeaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imeaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imeaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imeaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imeaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imeaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imeaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imeaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imeaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imeaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imeaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
imea004       varchar2(1)      /* 單據輸入產品特徵自動開窗 */
);
alter table imea_t add constraint imea_pk primary key (imeaent,imea001) enable validate;

create unique index imea_pk on imea_t (imeaent,imea001);

grant select on imea_t to tiptop;
grant update on imea_t to tiptop;
grant delete on imea_t to tiptop;
grant insert on imea_t to tiptop;

exit;
