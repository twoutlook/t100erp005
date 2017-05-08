/* 
================================================================================
檔案代號:imaq_t
檔案名稱:料件工單低階碼檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imaq_t
(
imaqent       number(5)      ,/* 企業代碼 */
imaq001       varchar2(40)      ,/* 料件編號 */
imaq002       varchar2(256)      ,/* 產品特徵 */
imaq003       number(5,0)      ,/* 工單低階碼 */
imaqownid       varchar2(20)      ,/* 資料所有者 */
imaqowndp       varchar2(10)      ,/* 資料所屬部門 */
imaqcrtid       varchar2(20)      ,/* 資料建立者 */
imaqcrtdp       varchar2(10)      ,/* 資料建立部門 */
imaqcrtdt       timestamp(0)      ,/* 資料創建日 */
imaqmodid       varchar2(20)      ,/* 資料修改者 */
imaqmoddt       timestamp(0)      ,/* 最近修改日 */
imaqcnfid       varchar2(20)      ,/* 資料確認者 */
imaqcnfdt       timestamp(0)      ,/* 資料確認日 */
imaqstus       varchar2(10)      ,/* 狀態碼 */
imaqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imaqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imaqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imaqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imaqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imaqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imaqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imaqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imaqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imaqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imaqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imaqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imaqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imaqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imaqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imaqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imaqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imaqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imaqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imaqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imaqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imaqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imaqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imaqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imaqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imaqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imaqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imaqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imaqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imaqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imaq_t add constraint imaq_pk primary key (imaqent,imaq001,imaq002) enable validate;

create unique index imaq_pk on imaq_t (imaqent,imaq001,imaq002);

grant select on imaq_t to tiptop;
grant update on imaq_t to tiptop;
grant delete on imaq_t to tiptop;
grant insert on imaq_t to tiptop;

exit;
