/* 
================================================================================
檔案代號:bgaa_t
檔案名稱:預算編號檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgaa_t
(
bgaaent       number(5)      ,/* 企業編號 */
bgaastus       varchar2(10)      ,/* 狀態碼 */
bgaa001       varchar2(10)      ,/* 預算編號 */
bgaa002       varchar2(10)      ,/* 預算週期 */
bgaa003       varchar2(10)      ,/* 預算幣別 */
bgaa004       varchar2(10)      ,/* 編制匯率 */
bgaa005       varchar2(10)      ,/* 執行匯率 */
bgaa006       varchar2(1)      ,/* 使用預測 */
bgaa007       varchar2(1)      ,/* 編制起點 */
bgaa008       varchar2(5)      ,/* 使用預算項目參照表 */
bgaa009       varchar2(5)      ,/* 現金異動表編碼 */
bgaaownid       varchar2(20)      ,/* 資料所有者 */
bgaaowndp       varchar2(10)      ,/* 資料所屬部門 */
bgaacrtid       varchar2(20)      ,/* 資料建立者 */
bgaacrtdp       varchar2(10)      ,/* 資料建立部門 */
bgaacrtdt       timestamp(0)      ,/* 資料創建日 */
bgaamodid       varchar2(20)      ,/* 資料修改者 */
bgaamoddt       timestamp(0)      ,/* 最近修改日 */
bgaa010       varchar2(10)      ,/* 預算組織版本 */
bgaa011       varchar2(10)      ,/* 最上層組織 */
bgaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgaaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
bgaa012       varchar2(1)      /* 使用科目預算 */
);
alter table bgaa_t add constraint bgaa_pk primary key (bgaaent,bgaa001) enable validate;

create unique index bgaa_pk on bgaa_t (bgaaent,bgaa001);

grant select on bgaa_t to tiptop;
grant update on bgaa_t to tiptop;
grant delete on bgaa_t to tiptop;
grant insert on bgaa_t to tiptop;

exit;
