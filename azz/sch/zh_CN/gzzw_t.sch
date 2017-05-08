/* 
================================================================================
檔案代號:gzzw_t
檔案名稱:產品作業名稱轉換表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzzw_t
(
gzzwownid       varchar2(20)      ,/* 資料所有者 */
gzzwowndp       varchar2(10)      ,/* 資料所屬部門 */
gzzwcrtid       varchar2(20)      ,/* 資料建立者 */
gzzwcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzzwcrtdt       timestamp(0)      ,/* 資料創建日 */
gzzwmodid       varchar2(20)      ,/* 資料修改者 */
gzzwmoddt       timestamp(0)      ,/* 最近修改日 */
gzzwstus       varchar2(10)      ,/* 狀態碼 */
gzzw001       varchar2(20)      ,/* TIPTOP作業編號 */
gzzw002       varchar2(80)      ,/* TIPTOP作業說明 */
gzzw003       varchar2(20)      ,/* 對應作業編號 */
gzzw004       varchar2(255)      ,/* 查無對應說明 */
gzzwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzzwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzzwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzzwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzzwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzzwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzzwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzzwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzzwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzzwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzzwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzzwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzzwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzzwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzzwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzzwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzzwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzzwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzzwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzzwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzzwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzzwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzzwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzzwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzzwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzzwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzzwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzzwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzzwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzzwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on gzzw_t to tiptop;
grant update on gzzw_t to tiptop;
grant delete on gzzw_t to tiptop;
grant insert on gzzw_t to tiptop;

exit;
