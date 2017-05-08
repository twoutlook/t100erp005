/* 
================================================================================
檔案代號:rtcd_t
檔案名稱:每日預算结果查詢檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtcd_t
(
rtcdent       number(5)      ,/* 企業編號 */
rtcdsite       varchar2(10)      ,/* 營運據點 */
rtcd001       number(10,0)      ,/* 預算期別 */
rtcd002       varchar2(10)      ,/* 部門編號 */
rtcd003       varchar2(10)      ,/* 品類編號 */
rtcd004       varchar2(10)      ,/* 行類型 */
rtcd005       varchar2(10)      ,/* 指標編號 */
rtcd006       varchar2(10)      ,/* 性質 */
rtcd007       varchar2(500)      ,/* 1 */
rtcd008       varchar2(500)      ,/* 2 */
rtcd009       varchar2(500)      ,/* 3 */
rtcd010       varchar2(500)      ,/* 4 */
rtcd011       varchar2(500)      ,/* 5 */
rtcd012       varchar2(500)      ,/* 6 */
rtcd013       varchar2(500)      ,/* 7 */
rtcd014       varchar2(500)      ,/* 8 */
rtcd015       varchar2(500)      ,/* 9 */
rtcd016       varchar2(500)      ,/* 10 */
rtcd017       varchar2(500)      ,/* 11 */
rtcd018       varchar2(500)      ,/* 12 */
rtcd019       varchar2(500)      ,/* 13 */
rtcd020       varchar2(500)      ,/* 14 */
rtcd021       varchar2(500)      ,/* 15 */
rtcd022       varchar2(500)      ,/* 16 */
rtcd023       varchar2(500)      ,/* 17 */
rtcd024       varchar2(500)      ,/* 18 */
rtcd025       varchar2(500)      ,/* 19 */
rtcd026       varchar2(500)      ,/* 20 */
rtcd027       varchar2(500)      ,/* 21 */
rtcd028       varchar2(500)      ,/* 22 */
rtcd029       varchar2(500)      ,/* 23 */
rtcd030       varchar2(500)      ,/* 24 */
rtcd031       varchar2(500)      ,/* 25 */
rtcd032       varchar2(500)      ,/* 26 */
rtcd033       varchar2(500)      ,/* 27 */
rtcd034       varchar2(500)      ,/* 28 */
rtcd035       varchar2(500)      ,/* 29 */
rtcd036       varchar2(500)      ,/* 30 */
rtcd037       varchar2(500)      ,/* 31 */
rtcdownid       varchar2(20)      ,/* 資料所有者 */
rtcdowndp       varchar2(10)      ,/* 資料所屬部門 */
rtcdcrtid       varchar2(20)      ,/* 資料建立者 */
rtcdcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtcdcrtdt       timestamp(0)      ,/* 資料創建日 */
rtcdmodid       varchar2(20)      ,/* 資料修改者 */
rtcdmoddt       timestamp(0)      ,/* 最近修改日 */
rtcdstus       varchar2(10)      ,/* 狀態碼 */
rtcdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtcdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtcdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtcdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtcdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtcdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtcdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtcdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtcdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtcdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtcdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtcdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtcdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtcdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtcdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtcdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtcdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtcdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtcdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtcdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtcdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtcdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtcdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtcdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtcdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtcdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtcdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtcdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtcdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtcdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtcd_t add constraint rtcd_pk primary key (rtcdent,rtcdsite,rtcd001,rtcd002,rtcd003,rtcd004,rtcd005) enable validate;

create unique index rtcd_pk on rtcd_t (rtcdent,rtcdsite,rtcd001,rtcd002,rtcd003,rtcd004,rtcd005);

grant select on rtcd_t to tiptop;
grant update on rtcd_t to tiptop;
grant delete on rtcd_t to tiptop;
grant insert on rtcd_t to tiptop;

exit;
