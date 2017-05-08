/* 
================================================================================
檔案代號:gzye_t
檔案名稱:個資遮罩樣式設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzye_t
(
gzyeent       number(5)      ,/* 企業代碼 */
gzyeownid       varchar2(20)      ,/* 資料所有者 */
gzyeowndp       varchar2(10)      ,/* 資料所屬部門 */
gzyecrtid       varchar2(20)      ,/* 資料建立者 */
gzyecrtdp       varchar2(10)      ,/* 資料建立部門 */
gzyecrtdt       timestamp(0)      ,/* 資料創建日 */
gzyemodid       varchar2(20)      ,/* 資料修改者 */
gzyemoddt       timestamp(0)      ,/* 最近修改日 */
gzyestus       varchar2(10)      ,/* 狀態碼 */
gzye001       varchar2(10)      ,/* 個資遮罩樣式編號 */
gzye002       varchar2(80)      ,/* 個資遮罩樣式說明 */
gzye003       varchar2(10)      ,/* 個資種類編號 */
gzye004       varchar2(1)      ,/* 遮罩方法 */
gzye005       varchar2(1)      ,/* 字數或字元 */
gzyeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzyeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzyeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzyeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzyeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzyeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzyeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzyeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzyeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzyeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzyeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzyeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzyeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzyeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzyeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzyeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzyeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzyeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzyeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzyeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzyeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzyeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzyeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzyeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzyeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzyeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzyeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzyeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzyeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzyeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzye_t add constraint gzye_pk primary key (gzyeent,gzye001) enable validate;

create unique index gzye_pk on gzye_t (gzyeent,gzye001);

grant select on gzye_t to tiptop;
grant update on gzye_t to tiptop;
grant delete on gzye_t to tiptop;
grant insert on gzye_t to tiptop;

exit;
