/* 
================================================================================
檔案代號:bxaa_t
檔案名稱:保稅BOM起始編號設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bxaa_t
(
bxaaent       number(5)      ,/* 企業編號 */
bxaasite       varchar2(10)      ,/* 營運據點 */
bxaa001       varchar2(40)      ,/* BOM編號字首 */
bxaa002       number(5,0)      ,/* BOM編號流水號 */
bxaa003       varchar2(40)      ,/* BOM編號字尾 */
bxaaownid       varchar2(20)      ,/* 資料所有者 */
bxaaowndp       varchar2(10)      ,/* 資料所屬部門 */
bxaacrtid       varchar2(20)      ,/* 資料建立者 */
bxaacrtdp       varchar2(10)      ,/* 資料建立部門 */
bxaacrtdt       timestamp(0)      ,/* 資料創建日 */
bxaamodid       varchar2(20)      ,/* 資料修改者 */
bxaamoddt       timestamp(0)      ,/* 最近修改日 */
bxaastus       varchar2(10)      ,/* 狀態碼 */
bxaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxaa_t add constraint bxaa_pk primary key (bxaaent,bxaasite,bxaa001,bxaa003) enable validate;

create unique index bxaa_pk on bxaa_t (bxaaent,bxaasite,bxaa001,bxaa003);

grant select on bxaa_t to tiptop;
grant update on bxaa_t to tiptop;
grant delete on bxaa_t to tiptop;
grant insert on bxaa_t to tiptop;

exit;
