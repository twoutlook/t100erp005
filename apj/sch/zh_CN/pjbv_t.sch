/* 
================================================================================
檔案代號:pjbv_t
檔案名稱:專案活動變更單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbv_t
(
pjbvent       number(5)      ,/* 企業編號 */
pjbv001       varchar2(20)      ,/* 專案編號 */
pjbv002       varchar2(30)      ,/* 活動編號 */
pjbv003       varchar2(10)      ,/* 活動類型 */
pjbv004       varchar2(10)      ,/* 部門編號 */
pjbv005       varchar2(30)      ,/* 前置活動編號 */
pjbv006       varchar2(10)      ,/* 前置活動關係類型 */
pjbv007       varchar2(30)      ,/* 後續活動編號 */
pjbv008       number(15,3)      ,/* 容差時間 */
pjbv009       varchar2(20)      ,/* 負責人員 */
pjbv010       varchar2(10)      ,/* 負責部門 */
pjbv011       varchar2(30)      ,/* 對應WBS編號 */
pjbv012       number(20,6)      ,/* 活動權重因子 */
pjbv013       varchar2(10)      ,/* 計畫完工比例方式 */
pjbv014       varchar2(10)      ,/* 實際完工比例方式 */
pjbv015       number(15,3)      ,/* 標準作業天數 */
pjbv016       number(15,3)      ,/* 最少作業天數 */
pjbv017       date      ,/* 預計開始日期 */
pjbv018       date      ,/* 預計完成日期 */
pjbv019       date      ,/* 最早開始日期 */
pjbv020       date      ,/* 最早完成日期 */
pjbv021       date      ,/* 最晚開始日期 */
pjbv022       date      ,/* 最晚完成日期 */
pjbv023       date      ,/* 實際開始日期 */
pjbv024       date      ,/* 實際完成日期 */
pjbv025       number(20,6)      ,/* 完工率 */
pjbv026       date      ,/* 推算進度更新日期 */
pjbv027       date      ,/* 最新進度更新日期 */
pjbv028       varchar2(20)      ,/* 最新進度更新人員 */
pjbv029       varchar2(10)      ,/* 狀態碼 */
pjbv030       number(5,0)      ,/* 版本 */
pjbv900       number(10,0)      ,/* 變更序 */
pjbv901       varchar2(1)      ,/* 變更類型 */
pjbv902       date      ,/* 變更日期 */
pjbv903       varchar2(10)      ,/* 變更理由 */
pjbv904       varchar2(255)      ,/* 變更備註 */
pjbvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pjbv_t add constraint pjbv_pk primary key (pjbvent,pjbv001,pjbv002,pjbv900) enable validate;

create unique index pjbv_pk on pjbv_t (pjbvent,pjbv001,pjbv002,pjbv900);

grant select on pjbv_t to tiptop;
grant update on pjbv_t to tiptop;
grant delete on pjbv_t to tiptop;
grant insert on pjbv_t to tiptop;

exit;
