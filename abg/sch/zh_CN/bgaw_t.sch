/* 
================================================================================
檔案代號:bgaw_t
檔案名稱:預算樣表設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgaw_t
(
bgawent       number(5)      ,/* 企業編號 */
bgawownid       varchar2(20)      ,/* 資料所有者 */
bgawowndp       varchar2(10)      ,/* 資料所屬部門 */
bgawcrtid       varchar2(20)      ,/* 資料建立者 */
bgawcrtdp       varchar2(10)      ,/* 資料建立部門 */
bgawcrtdt       timestamp(0)      ,/* 資料創建日 */
bgawmodid       varchar2(20)      ,/* 資料修改者 */
bgawmoddt       timestamp(0)      ,/* 最近修改日 */
bgawstus       varchar2(10)      ,/* 狀態碼 */
bgaw001       varchar2(10)      ,/* 樣表編號 */
bgaw002       number(10,0)      ,/* 項次 */
bgaw003       varchar2(1)      ,/* 維度來源 */
bgaw004       varchar2(10)      ,/* 預算維度 */
bgaw005       varchar2(1)      ,/* 使用否 */
bgaw006       varchar2(1)      ,/* 樣表位置 */
bgawud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgawud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgawud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgawud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgawud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgawud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgawud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgawud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgawud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgawud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgawud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgawud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgawud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgawud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgawud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgawud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgawud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgawud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgawud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgawud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgawud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgawud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgawud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgawud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgawud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgawud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgawud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgawud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgawud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgawud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
bgaw007       varchar2(10)      /* 核算項類型編號 */
);
alter table bgaw_t add constraint bgaw_pk primary key (bgawent,bgaw001,bgaw002) enable validate;

create unique index bgaw_pk on bgaw_t (bgawent,bgaw001,bgaw002);

grant select on bgaw_t to tiptop;
grant update on bgaw_t to tiptop;
grant delete on bgaw_t to tiptop;
grant insert on bgaw_t to tiptop;

exit;
