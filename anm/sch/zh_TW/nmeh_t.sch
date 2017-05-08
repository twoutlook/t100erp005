/* 
================================================================================
檔案代號:nmeh_t
檔案名稱:資金模擬匯率檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmeh_t
(
nmehent       number(5)      ,/* 企業代碼 */
nmehownid       varchar2(20)      ,/* 資料所有者 */
nmehowndp       varchar2(10)      ,/* 資料所屬部門 */
nmehcrtid       varchar2(20)      ,/* 資料建立者 */
nmehcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmehcrtdt       timestamp(0)      ,/* 資料創建日 */
nmehmodid       varchar2(20)      ,/* 資料修改者 */
nmehmoddt       timestamp(0)      ,/* 最近修改日 */
nmehstus       varchar2(10)      ,/* 狀態碼 */
nmeh001       varchar2(10)      ,/* 模擬基礎貨幣 */
nmeh002       date      ,/* 日期 */
nmeh003       varchar2(10)      ,/* 兌換貨幣 */
nmeh004       varchar2(1)      ,/* 匯率輸入方式 */
nmeh005       number(20,10)      ,/* 匯率 */
nmeh006       number(20,6)      ,/* 模擬貨幣批量 */
nmeh007       number(20,6)      ,/* 兌換貨幣批量 */
nmehud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmehud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmehud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmehud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmehud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmehud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmehud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmehud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmehud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmehud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmehud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmehud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmehud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmehud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmehud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmehud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmehud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmehud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmehud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmehud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmehud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmehud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmehud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmehud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmehud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmehud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmehud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmehud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmehud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmehud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmeh_t add constraint nmeh_pk primary key (nmehent,nmeh001,nmeh002,nmeh003) enable validate;

create unique index nmeh_pk on nmeh_t (nmehent,nmeh001,nmeh002,nmeh003);

grant select on nmeh_t to tiptop;
grant update on nmeh_t to tiptop;
grant delete on nmeh_t to tiptop;
grant insert on nmeh_t to tiptop;

exit;
