/* 
================================================================================
檔案代號:oobx_t
檔案名稱:單據別設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oobx_t
(
oobxent       number(5)      ,/* 企業編號 */
oobx001       varchar2(5)      ,/* 單據別 */
oobx002       varchar2(4)      ,/* 模組別 */
oobx003       varchar2(10)      ,/* 單據性質 */
oobx004       varchar2(20)      ,/* 對應作業編號 */
oobx005       varchar2(1)      ,/* 自動編碼否 */
oobx006       varchar2(1)      ,/* 期別碼 */
oobx007       number(5,0)      ,/* 所剩流水號長度 */
oobx008       varchar2(20)      ,/* 編碼結果 */
oobx009       varchar2(1)      ,/* 于aoor700揭露 */
oobxownid       varchar2(20)      ,/* 資料所有者 */
oobxowndp       varchar2(10)      ,/* 資料所屬部門 */
oobxcrtid       varchar2(20)      ,/* 資料建立者 */
oobxcrtdp       varchar2(10)      ,/* 資料建立部門 */
oobxcrtdt       timestamp(0)      ,/* 資料創建日 */
oobxmodid       varchar2(20)      ,/* 資料修改者 */
oobxmoddt       timestamp(0)      ,/* 最近修改日 */
oobxstus       varchar2(10)      ,/* 狀態碼 */
oobxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oobx_t add constraint oobx_pk primary key (oobxent,oobx001) enable validate;

create unique index oobx_pk on oobx_t (oobxent,oobx001);

grant select on oobx_t to tiptop;
grant update on oobx_t to tiptop;
grant delete on oobx_t to tiptop;
grant insert on oobx_t to tiptop;

exit;
