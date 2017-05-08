/* 
================================================================================
檔案代號:rtcb_t
檔案名稱:預算設定維護檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtcb_t
(
rtcbent       number(5)      ,/* 企業編號 */
rtcbsite       varchar2(10)      ,/* 營運據點 */
rtcb001       number(5,0)      ,/* 預算年度 */
rtcb002       varchar2(10)      ,/* 部門編號 */
rtcb003       varchar2(10)      ,/* 品類編號 */
rtcb004       varchar2(10)      ,/* 指標編號 */
rtcb005       number(20,6)      ,/* 期別1月 */
rtcb006       number(20,6)      ,/* 期別2月 */
rtcb007       number(20,6)      ,/* 期別3月 */
rtcb008       number(20,6)      ,/* 期別4月 */
rtcb009       number(20,6)      ,/* 期別5月 */
rtcb010       number(20,6)      ,/* 期別6月 */
rtcb011       number(20,6)      ,/* 期別7月 */
rtcb012       number(20,6)      ,/* 期別8月 */
rtcb013       number(20,6)      ,/* 期別9月 */
rtcb014       number(20,6)      ,/* 期別10月 */
rtcb015       number(20,6)      ,/* 期別11月 */
rtcb016       number(20,6)      ,/* 期別12月 */
rtcbownid       varchar2(20)      ,/* 資料所有者 */
rtcbowndp       varchar2(10)      ,/* 資料所屬部門 */
rtcbcrtid       varchar2(20)      ,/* 資料建立者 */
rtcbcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtcbcrtdt       timestamp(0)      ,/* 資料創建日 */
rtcbmodid       varchar2(20)      ,/* 資料修改者 */
rtcbmoddt       timestamp(0)      ,/* 最近修改日 */
rtcbstus       varchar2(10)      ,/* 狀態碼 */
rtcbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtcbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtcbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtcbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtcbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtcbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtcbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtcbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtcbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtcbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtcbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtcbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtcbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtcbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtcbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtcbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtcbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtcbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtcbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtcbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtcbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtcbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtcbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtcbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtcbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtcbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtcbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtcbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtcbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtcbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtcb_t add constraint rtcb_pk primary key (rtcbent,rtcbsite,rtcb001,rtcb002,rtcb003,rtcb004) enable validate;

create unique index rtcb_pk on rtcb_t (rtcbent,rtcbsite,rtcb001,rtcb002,rtcb003,rtcb004);

grant select on rtcb_t to tiptop;
grant update on rtcb_t to tiptop;
grant delete on rtcb_t to tiptop;
grant insert on rtcb_t to tiptop;

exit;
