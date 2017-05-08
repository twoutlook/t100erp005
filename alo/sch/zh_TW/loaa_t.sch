/* 
================================================================================
檔案代號:loaa_t
檔案名稱:相關文件主表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table loaa_t
(
loaaent       number(5)      ,/* 企業編號 */
loaa001       varchar2(500)      ,/* 單據組合Key */
loaa002       varchar2(1)      ,/* 未使用屬性 */
loaa003       varchar2(1)      ,/* 未使用屬性 */
loaa004       varchar2(1)      ,/* 用途類別 */
loaa005       varchar2(1)      ,/* 預設顯示圖片 */
loaa006       number(5,0)      ,/* 文件版本 */
loaa007       number(5,0)      ,/* 文件序號 */
loaa008       varchar2(1)      ,/* 文件存放類型 */
loaaownid       varchar2(20)      ,/* 資料所有者 */
loaaowndp       varchar2(10)      ,/* 資料所屬部門 */
loaacrtid       varchar2(20)      ,/* 資料建立者 */
loaacrtdp       varchar2(10)      ,/* 資料建立部門 */
loaacrtdt       timestamp(0)      ,/* 資料創建日 */
loaamodid       varchar2(20)      ,/* 資料修改者 */
loaamoddt       timestamp(0)      ,/* 最近修改日 */
loaacnfid       varchar2(20)      ,/* 資料確認者 */
loaacnfdt       timestamp(0)      ,/* 資料確認日 */
loaastus       varchar2(10)      ,/* 狀態碼 */
loaa009       varchar2(40)      ,/* 文件GUID */
loaa010       varchar2(255)      ,/* 文件原始檔名 */
loaa011       varchar2(1)      ,/* 文件型態 */
loaa012       varchar2(255)      ,/* 文件位置(URL) */
loaa013       varchar2(255)      ,/* 文件說明 */
loaa014       varchar2(1)      ,/* 讀取權限 */
loaa015       varchar2(1)      ,/* 修改權限 */
loaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
loaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
loaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
loaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
loaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
loaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
loaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
loaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
loaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
loaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
loaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
loaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
loaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
loaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
loaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
loaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
loaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
loaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
loaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
loaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
loaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
loaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
loaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
loaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
loaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
loaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
loaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
loaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
loaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
loaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table loaa_t add constraint loaa_pk primary key (loaaent,loaa001,loaa006,loaa007) enable validate;

create unique index loaa_pk on loaa_t (loaaent,loaa001,loaa006,loaa007);

grant select on loaa_t to tiptop;
grant update on loaa_t to tiptop;
grant delete on loaa_t to tiptop;
grant insert on loaa_t to tiptop;

exit;
