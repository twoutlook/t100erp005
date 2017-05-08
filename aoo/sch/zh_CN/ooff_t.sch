/* 
================================================================================
檔案代號:ooff_t
檔案名稱:備註檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooff_t
(
ooffent       number(5)      ,/* 企業編號 */
ooffstus       varchar2(10)      ,/* 狀態碼 */
ooff001       varchar2(10)      ,/* 備註類型 */
ooff002       varchar2(40)      ,/* 第一KEY值 */
ooff003       varchar2(40)      ,/* 第二KEY值 */
ooff004       varchar2(40)      ,/* 第三KEY值 */
ooff005       varchar2(40)      ,/* 第四KEY值 */
ooff006       varchar2(40)      ,/* 第五KEY值 */
ooff007       varchar2(40)      ,/* 第六KEY值 */
ooff008       varchar2(40)      ,/* 第七KEY值 */
ooff009       varchar2(40)      ,/* 第八KEY值 */
ooff010       varchar2(40)      ,/* 第九KEY值 */
ooff011       varchar2(40)      ,/* 第十KEY值 */
ooff012       varchar2(10)      ,/* 控制類型 */
ooff013       varchar2(4000)      ,/* 備註說明 */
ooff014       date      ,/* 失效日期 */
ooff015       varchar2(1)      ,/* 內部資訊傳遞 */
ooffownid       varchar2(20)      ,/* 資料所有者 */
ooffowndp       varchar2(10)      ,/* 資料所屬部門 */
ooffcrtid       varchar2(20)      ,/* 資料建立者 */
ooffcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooffcrtdt       timestamp(0)      ,/* 資料創建日 */
ooffmodid       varchar2(20)      ,/* 資料修改者 */
ooffmoddt       timestamp(0)      ,/* 最近修改日 */
ooffud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooffud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooffud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooffud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooffud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooffud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooffud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooffud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooffud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooffud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooffud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooffud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooffud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooffud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooffud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooffud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooffud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooffud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooffud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooffud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooffud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooffud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooffud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooffud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooffud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooffud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooffud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooffud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooffud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooffud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooff_t add constraint ooff_pk primary key (ooffent,ooff001,ooff002,ooff003,ooff004,ooff005,ooff006,ooff007,ooff008,ooff009,ooff010,ooff011,ooff012) enable validate;

create unique index ooff_pk on ooff_t (ooffent,ooff001,ooff002,ooff003,ooff004,ooff005,ooff006,ooff007,ooff008,ooff009,ooff010,ooff011,ooff012);

grant select on ooff_t to tiptop;
grant update on ooff_t to tiptop;
grant delete on ooff_t to tiptop;
grant insert on ooff_t to tiptop;

exit;
