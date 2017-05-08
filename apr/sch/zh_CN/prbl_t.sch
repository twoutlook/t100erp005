/* 
================================================================================
檔案代號:prbl_t
檔案名稱:電子秤檔案格式定義資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table prbl_t
(
prblent       number(5)      ,/* 企業編號 */
prblunit       varchar2(10)      ,/* 應用組織 */
prbl001       varchar2(10)      ,/* 電子秤編號 */
prbl002       varchar2(80)      ,/* 電子秤說明 */
prbl003       varchar2(10)      ,/* 電子秤類型 */
prbl004       varchar2(255)      ,/* 導出路徑 */
prbl005       varchar2(10)      ,/* 導出文件格式 */
prbl006       varchar2(10)      ,/* 數據分隔符 */
prblstus       varchar2(10)      ,/* 狀態 */
prblownid       varchar2(20)      ,/* 資料所屬者 */
prblowndp       varchar2(10)      ,/* 資料所屬部門 */
prblcrtid       varchar2(20)      ,/* 資料建立者 */
prblcrtdp       varchar2(10)      ,/* 資料建立部門 */
prblcrtdt       timestamp(0)      ,/* 資料創建日 */
prblmodid       varchar2(20)      ,/* 資料修改者 */
prblmoddt       timestamp(0)      ,/* 最近修改日 */
prblud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prblud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prblud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prblud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prblud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prblud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prblud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prblud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prblud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prblud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prblud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prblud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prblud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prblud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prblud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prblud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prblud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prblud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prblud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prblud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prblud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prblud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prblud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prblud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prblud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prblud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prblud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prblud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prblud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prblud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prbl_t add constraint prbl_pk primary key (prblent,prbl001) enable validate;

create unique index prbl_pk on prbl_t (prblent,prbl001);

grant select on prbl_t to tiptop;
grant update on prbl_t to tiptop;
grant delete on prbl_t to tiptop;
grant insert on prbl_t to tiptop;

exit;
