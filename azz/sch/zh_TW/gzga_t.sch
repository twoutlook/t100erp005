/* 
================================================================================
檔案代號:gzga_t
檔案名稱:相關檔案資料單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzga_t
(
gzgastus       varchar2(10)      ,/* 狀態碼 */
gzgaent       number(5)      ,/* 企業編號 */
gzga001       varchar2(80)      ,/* 第一組 Key 值 */
gzga002       varchar2(80)      ,/* 第二組 Key 值 */
gzga003       varchar2(80)      ,/* 第三組 Key 值 */
gzga004       varchar2(80)      ,/* 第四組 Key 值 */
gzga005       varchar2(80)      ,/* 第五組 Key 值 */
gzga006       number(10,0)      ,/* 序號 */
gzga007       number(10,0)      ,/* 文件編號 */
gzga008       varchar2(10)      ,/* 文件類型 */
gzga009       varchar2(10)      ,/* 文件分輯 */
gzga010       varchar2(10)      ,/* 文件版本 */
gzgaownid       varchar2(20)      ,/* 資料所有者 */
gzgaowndp       varchar2(10)      ,/* 資料所屬部門 */
gzgacrtid       varchar2(20)      ,/* 資料建立者 */
gzgacrtdp       varchar2(10)      ,/* 資料建立部門 */
gzgacrtdt       timestamp(0)      ,/* 資料創建日 */
gzgamodid       varchar2(20)      ,/* 資料修改者 */
gzgamoddt       timestamp(0)      ,/* 最近修改日 */
gzgaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzgaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzgaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzgaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzgaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzgaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzgaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzgaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzgaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzgaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzgaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzgaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzgaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzgaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzgaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzgaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzgaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzgaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzgaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzgaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzgaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzgaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzgaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzgaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzgaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzgaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzgaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzgaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzgaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzgaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzga_t add constraint gzga_pk primary key (gzgaent,gzga001,gzga002,gzga003,gzga004,gzga005,gzga006) enable validate;

create unique index gzga_pk on gzga_t (gzgaent,gzga001,gzga002,gzga003,gzga004,gzga005,gzga006);

grant select on gzga_t to tiptop;
grant update on gzga_t to tiptop;
grant delete on gzga_t to tiptop;
grant insert on gzga_t to tiptop;

exit;
